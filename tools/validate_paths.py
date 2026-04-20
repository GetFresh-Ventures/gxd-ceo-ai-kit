import os
import re
from pathlib import Path

def check_skills():
    repo_dir = Path(os.getcwd())
    skills_dir = repo_dir / "skills"
    
    broken_references = []
    
    for skill_file in skills_dir.glob("*/SKILL.md"):
        content = skill_file.read_text()
        
        # Regex to find paths inside bash code blocks, or inline code blocks
        lines = content.split('\n')
        for i, line in enumerate(lines):
            # Check for python commands
            if re.search(r"python3?\s+([^\"\'\n\s]+\.py)", line):
                matches = re.findall(r"python3?\s+([^\"\'\n\s]+\.py)", line)
                for py_script in matches:
                    if py_script.startswith("~/"):
                        resolved = Path(py_script.replace("~", str(Path.home())))
                    elif py_script.startswith("./"):
                        resolved = repo_dir / py_script[2:]
                    elif not py_script.startswith("/"):
                        resolved = repo_dir / py_script
                    else:
                        resolved = Path(py_script)
                        
                    if not resolved.exists():
                        broken_references.append(f"{skill_file.parent.name}:{i+1} -> Missing {py_script}")
    
    for br in broken_references:
        print(br)
        
    print(f"Total broken references found: {len(broken_references)}")

if __name__ == "__main__":
    check_skills()
