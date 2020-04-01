import os
import subprocess

os.system('git remote update')  # update remote repo

# script to check the status
statusCheckScript = """
#!/bin/sh

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi
"""
statusCheck = subprocess.check_output(['bash', '-c', statusCheckScript]).decode('utf-8').strip()

if statusCheck == "Need to pull":
    print("Need to pull")
elif statusCheck == "Need to push":
    print("Need to push")