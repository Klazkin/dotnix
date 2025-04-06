import os
import shutil

# Step 1: Find the real (read-only) config file
config_symlink = os.path.expanduser("~/.config/oh-my-posh/config.json")

if not os.path.islink(config_symlink):
    print(f"Error: {config_symlink} is not a symlink.")
    exit(0)

real_path = os.readlink(config_symlink)
print(f"Resolved real path: {real_path}")

# Step 2: Read the file content
with open(real_path, "r") as file:
    content = file.read()

# Step 3: Replace "\\" with "\"
fixed_content = content.replace("\\\\", "\\")

# Step 4: Write the fixed content to a new writable location
new_path = os.path.expanduser("~/.config/oh-my-posh/config-fixed.json")
with open(new_path, "w") as file:
    file.write(fixed_content)

# Step 5: Replace the symlink with the new file
os.remove(config_symlink)  # Remove the old symlink
os.symlink(new_path, config_symlink)  # Point to the new file

print(f"Fixed config written to: {new_path}")
