#!/usr/bin/python

from git import Repo
import subprocess
import sys
import shutil
import os

URL = "https://github.com/CDPS-ETSIT/practica_creativa2.git"
REPO_PATH = f"{os.getcwd()}/app"

def _cleanup_from_previous_executions ():
    try:
        shutil.rmtree(REPO_PATH)
    except Exception as e:
        print(f"Error deleting directoy: {e}")

def _clone_repo_and_go():
    print(REPO_PATH)
    Repo.clone_from(URL, REPO_PATH)
    os.chdir(f"{REPO_PATH}/bookinfo/src/productpage")

def _install_deps():
    subprocess.check_call([sys.executable, '-m', 'pip', '--version'])
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-r', 'requirements.txt'])

if __name__=="__main__":
    _cleanup_from_previous_executions()
    _clone_repo_and_go()
    _install_deps()