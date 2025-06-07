import subprocess
import sys
import uuid

def run(cmd, check=True, capture_output=False):
    print(f"\033[97m \uf313 \ue285 {cmd}\033[00m")
    result = subprocess.run(cmd, shell=True, check=check, capture_output=capture_output, text=True)
    return result.stdout.strip() if capture_output else None

def has_remote_changes():
    run("git fetch origin", check=True)
    local = run("git rev-parse @", capture_output=True)
    remote = run("git rev-parse @{u}", capture_output=True)
    base = run("git merge-base @ @{u}", capture_output=True)

    if local != remote:
        if local == base:
            print("❌ Your branch is behind the remote. Please pull changes.")
            return True
        elif remote == base:
            return False
        else:
            print("❌ Your branch and remote have diverged.")
            return True
    return False

def has_local_changes():
    status = run("git status --porcelain", capture_output=True)
    return bool(status.strip())

def main():
    try:
        if has_remote_changes():
            sys.exit("Aborting: Remote has changes.")

        if has_local_changes():
            run("git add .")
            commit_msg = f"Auto-update {uuid.uuid4()}"
            run(f"git commit -m \"{commit_msg}\"")
            run("git push origin HEAD")

        # run("sudo nixos-rebuild switch")
        run("echo DONE")
        print("✅ Rebuild complete.")
    except subprocess.CalledProcessError as e:
        print(f"Command failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
