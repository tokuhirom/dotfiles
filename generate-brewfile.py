#!/usr/bin/python3

import os
import subprocess
import json
import re

def get_formula_info(packages):
    """Retrieve name and description for formula packages using `brew info --json`."""
    cmd = ["brew", "info", "--json"] + packages
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        data = json.loads(result.stdout)
        return [(item["name"], item.get("desc", "No description available")) for item in data]
    except subprocess.CalledProcessError:
        return []

def get_cask_info(packages):
    """Retrieve name and description for cask packages using `brew info --cask`."""
    cmd = ["brew", "info", "--cask"] + packages
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        lines = result.stdout.splitlines()
        casks = []
        current_cask = {}
        for index, line in enumerate(lines):
            if line.startswith("==> "):
                if ':' in line:
                    current_cask["name"] = line.split(':')[0].split(' ')[1]
                elif line.startswith("==> Description"):
                    current_cask["desc"] = lines[index + 1].strip()
                    casks.append([current_cask['name'], current_cask['desc']])
                    current_cask = {}
        return casks
    except subprocess.CalledProcessError:
        return []

def get_mas_info(lines):
    """

    sample output of the mas list command:

        1289197285  MindNode        (2023.6)
        539883307   LINE            (9.5.0)
        1289583905  Pixelmator Pro  (3.6.14)
    """
    for line in lines:
        id_, name = re.match(r"\s*(\d+)\s+(.+?)\s+\(.+?\)", line).groups()
        yield name, id_

def generate_cask(script):
    script.write("# -----------------------------------'\n")
    script.write("# Installing casks...\n")
    script.write("# -----------------------------------'\n\n")
    cask_list = subprocess.getoutput("brew list --cask -1").splitlines()
    cask_info = get_cask_info(cask_list)
    for name, desc in cask_info:
        script.write(f"# {desc}\n")
        script.write(f"cask '{name}'\n\n")
    script.write("\n")

def generate_formula(script):
        script.write("# -----------------------------------'\n")
        script.write("# Installing formulae...\n")
        script.write("# -----------------------------------'\n\n")
        formula_list = subprocess.getoutput("brew leaves").splitlines()
        formula_info = get_formula_info(formula_list)
        for name, desc in formula_info:
            script.write(f"# {desc}\n")
            script.write(f"brew '{name}'\n\n")

def generate_mas(script):
        script.write("# -----------------------------------'\n")
        script.write("# Installing mas(Mac app store)...\n")
        script.write("# -----------------------------------'\n\n")
        mas_list = subprocess.getoutput("mas list").splitlines()
        mas_info = get_mas_info(mas_list)
        for name, id_ in mas_info:
            script.write(f"mas '{name}', id: {id_}\n\n")

def generate_script():
    """Generate a reinstallation script for Homebrew packages and casks."""
    output_script = "Brewfile"

    with open(output_script, "w") as script:
        generate_cask(script)
        generate_formula(script)
        generate_mas(script)

    print(f"Reinstallation script has been generated: {output_script}")

if __name__ == "__main__":
    generate_script()
