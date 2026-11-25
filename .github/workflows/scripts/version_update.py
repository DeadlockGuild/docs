import argparse, re
from datetime import datetime

username_to_name = {
    "carlo-nardin": "Carlo Nardin",
    "MattiaUnipd95": "Mattia Pasquato",
    "mscompar": "Mattia Scomparin",
    "niko-u1": "Nikola Mijanovic",
    "GiacomoUnipd": "Giacomo Ravazzolo",
    "godwin-17": "Godwin Agbleze"
}

def github_array_process(array_str: str) -> list[str]:
    array = array_str.split("\n")
    if len(array) > 1:
        array.pop(0)
        array.pop()
    for i, n in enumerate(array):
        n = n.strip()
        if n[-1] == ",":
            n = n[:-1]
        array[i] = n

    return array

def string_args_process(string_args: list[str]) -> list[str]:
    arg_strings = []
    for a in string_args:
        if a[0] == "[" and a[-1] == "]" and a.count("\n") > 0:
            arg_strings.extend(github_array_process(a))
        else:
            arg_strings.append(a)

    return arg_strings

def names_list_process(name_line: str, additional_names: list[str] = []) -> str:
    if name_line[-1] == ",":
        name_line = name_line[:-1]

    string = name_line.split(": ")[1]
    if string.count("(") > 0:
        string = string.split("(")[1].split(")")[0]
    str_list = string.split(", ")
    for i, s in enumerate(str_list):
        str_list[i] = s.split("\"")[1]
    if str_list.count('""') > 0:
        str_list.remove('""')

    for s in additional_names:
        name = (username_to_name[s] if username_to_name.get(s) else s)
        if str_list.count(name) < 1:
            str_list.append(name)

    names = "\", \"".join(str_list)
    names = "\"" + names + "\""
    if len(str_list) > 1:
        names = "(" + names + ")"


    return names


pre_parser = argparse.ArgumentParser(add_help=False)
#Version bump selection
version_selection_group = pre_parser.add_mutually_exclusive_group()
version_selection_group.add_argument("--major", action="store_const", help="Update the Major version", dest="bump_version", const="j")
version_selection_group.add_argument("--minor", action="store_const", help="Update the Minor version", dest="bump_version", const="n")
version_selection_group.add_argument("--patch", action="store_const", help="Update the Patch version", dest="bump_version", const="p")
#Default to bump minor version
pre_parser.set_defaults(bump_version="n")

version_bump, _ = pre_parser.parse_known_args()

parser = argparse.ArgumentParser(parents=[pre_parser])
#File to bump the version of
parser.add_argument("-f", "--file", required=True, dest="file")
#Who wrote the changes
parser.add_argument("-w", "--writer", nargs="+", required=True, dest="writer")
#Who reviewed the changes
parser.add_argument("-r", "--reviewer", nargs="+", required=(version_bump.bump_version != "j"), dest="reviewer")
#The description of the changes
parser.add_argument("-m", "--message", required=(version_bump.bump_version != "j"), dest="message")
parser.add_argument("-d", "--debug", action="store_true", dest="debug")

args = parser.parse_args()

if version_bump.bump_version == "j" and args.reviewer:
    parser.error("Aggiornare la versione major lo fa solo il responsabile senza verifica. Il campo verficatore (reviewer) non va inserito.\n")

with open(args.file, "r+") as file_handler:
    main_table_end_pattern = "^\\)$"
    main_version_pattern = "versione: \"\\d+?\\.\\d+?\\.\\d+?\","
    edit_registry_pattern = "registro_modifiche: \\("
    latest_edit_pattern = "\\d+?\\.\\d+?\\.\\d+?"
    writer_list_pattern = "redattore: \\(?\"[\\w\\s,]*?\"\\)?,"
    reviewer_list_pattern = "verificatore: \\(?\"[\\w\\s,]*?\",\\)?"
    secondary_table_pattern = "^#((table)|(tabella_decisioni))\\($"

    main_table_end_index = -1
    main_version_index = -1
    edit_registry_index = -1
    latest_edit_index = -1
    writer_list_index = -1
    reviewer_list_index = -1
    secondary_table_index = -1

    lines = file_handler.readlines()

    for index, line in enumerate(lines):
        if main_table_end_index == -1 and (match := re.search(main_table_end_pattern, line)):
            main_table_end_index = index
        elif main_version_index == -1 and (match := re.search(main_version_pattern, line)):
            main_version_index = index
        elif edit_registry_index == -1 and (match := re.search(edit_registry_pattern, line)):
            edit_registry_index = index
        elif latest_edit_index == -1 and (match := re.search(latest_edit_pattern, line)):
            latest_edit_index = index
        elif writer_list_index == -1 and (match := re.search(writer_list_pattern, line)):
            writer_list_index = index
        elif reviewer_list_index == -1 and (match := re.search(reviewer_list_pattern, line)):
            reviewer_list_index = index
        elif secondary_table_index == -1 and (match := re.search(secondary_table_pattern, line)):
            secondary_table_index = index

    assert main_table_end_index != -1 and (main_table_end_index < secondary_table_index or secondary_table_index == -1)

    version_major = "0"
    version_minor = "0"
    version_patch = "0"

    if writer_list_index == -1:
        lines.insert(main_table_end_index, "  redattore: \"\",")
        writer_list_index = main_table_end_index
        main_table_end_index += 1

    if reviewer_list_index == -1:
        lines.insert(main_table_end_index, "  verificatore: \"\",")
        reviewer_list_index = main_table_end_index
        main_table_end_index += 1

    edit_registry_str_start = ""
    edit_registry_str_end = ""

    if latest_edit_index == -1:
        if edit_registry_index == -1:
            lines.insert(main_table_end_index, "  registro_modifiche: (),")
            edit_registry_index = main_table_end_index
            main_table_end_index += 1

        edit_registry_tail = ""
        while lines[edit_registry_index][-1] != "(":
            edit_registry_tail = lines[edit_registry_index][-1] + edit_registry_tail
            lines[edit_registry_index] = lines[edit_registry_index][:-1]
        edit_registry_tail = "  " + edit_registry_tail + "\n"
        lines.insert(edit_registry_index + 1, edit_registry_tail)
        main_table_end_index += 1
        lines[edit_registry_index] = lines[edit_registry_index] + "\n"
    else:
        latest_version = lines[latest_edit_index].split(".")
        if latest_version[0].count("[") > 0:
            version_major = latest_version[0].split("[")[1]
            edit_registry_str_start = "["
        elif latest_version[0].count("\"") > 0:
            edit_registry_str_start = "\""
            version_major = latest_version[0].split("\"")[1]
        else:
            version_major = latest_version[0]

        version_minor = latest_version[1]

        if latest_version[2].count("]") > 0:
            version_patch = latest_version[2].split("]")[0]
            edit_registry_str_start = "]"
        elif latest_version[2].count("\"") > 0:
            version_patch = latest_version[2].split("\"")[0]
            edit_registry_str_end = "\""
        else:
            version_patch = latest_version[2]


    match version_bump.bump_version:
        case "j":
            version_major = str(int(version_major) + 1)
            version_minor = "0"
            version_patch = "0"
        case "n":
            version_minor = str(int(version_minor) + 1)
            version_patch = "0"
        case "p":
            version_patch = str(int(version_patch) + 1)

    writer_list = string_args_process(args.writer)
    writer_name = ", ".join([(username_to_name[w] if username_to_name.get(w) else w) for w in writer_list])
    reviewer_name = "-"
    if version_bump.bump_version != "j":
        reviewer_list = string_args_process(args.reviewer)
        reviewer_name = ", ".join([(username_to_name[r] if username_to_name.get(r) else r) for r in reviewer_list])
        lines[writer_list_index] = "  redattore: " + names_list_process(lines[writer_list_index], writer_list) + ",\n"
        lines[reviewer_list_index] = "  verificatore: " + names_list_process(lines[reviewer_list_index], reviewer_list) + ",\n"

    new_version_line = "    (" + edit_registry_str_start + version_major + "." + version_minor + "." + version_patch + edit_registry_str_end
    new_version_line = new_version_line + ", " + edit_registry_str_start + datetime.today().strftime("%Y-%m-%d") + edit_registry_str_end
    new_version_line = new_version_line + ", " + edit_registry_str_start + writer_name + edit_registry_str_end
    new_version_line = new_version_line + ", " + edit_registry_str_start + reviewer_name + edit_registry_str_end
    new_version_line = new_version_line + ", " + edit_registry_str_start + (args.message if args.message else "Approvazione del responsabile") + edit_registry_str_end
    new_version_line = new_version_line + "),\n"
    lines.insert(edit_registry_index + 1, new_version_line)

    main_version_line = "  versione: \"" + version_major + "." + version_minor + "." + version_patch + "\",\n"
    if main_version_index == -1:
        lines.insert(writer_list_index, main_version_line)
    else:
        lines[main_version_index] = main_version_line

    if args.debug:
        for l in lines:
            print(l)
    else:
        file_handler.seek(0)
        file_handler.writelines(lines)
        file_handler.truncate()
