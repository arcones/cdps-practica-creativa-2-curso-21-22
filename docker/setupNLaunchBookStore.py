from git import Repo
import subprocess
import sys
import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-p", "--port", help="The port where bookstore will run", default=9080, required=False, type=int)

args = parser.parse_args()

PORT = args.port

URL = "https://github.com/CDPS-ETSIT/practica_creativa2.git"
REPO_PATH = f"{os.getcwd()}/app"

def _clone_repo_and_go():
  print(REPO_PATH)
  Repo.clone_from(URL, REPO_PATH)
  os.chdir(f"{REPO_PATH}/bookinfo/src/productpage")


def _install_deps():
  try:
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-r', 'requirements.txt'])
  except:
    pass


def _fix_deps():
  subprocess.check_call(['pip', 'uninstall', '-y', 'urllib3', 'jsonchema'])
  subprocess.check_call(['pip', 'install', 'urllib3==1.24.1', 'jsonschema==2.6.0'])
  subprocess.check_call(['pip', 'install', '--upgrade', 'requests'])


def _set_website_title():
  if not 'GROUP_NUMBER' in os.environ:
    os.environ["GROUP_NUMBER"] = "Equipo 09"

  search_text = "BookInfo Sample"
  replace_text = f"BookInfo Sample {os.environ['GROUP_NUMBER']}"

  with open(r"./templates/productpage.html", "r+") as productpage_source:
    data = productpage_source.read()
    data = data.replace(search_text, replace_text)

  with open(r"./templates/productpage.html", 'w') as productpage_source:
    productpage_source.write(data)


def _run_app():
  subprocess.call([sys.executable, 'productpage_monolith.py', f"{PORT}"])

if __name__ == "__main__":
  _clone_repo_and_go()
  _install_deps()
  _fix_deps()
  _set_website_title()
  _run_app()
  _set_website_title()
