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


def _cleanup_from_previous_executions():
    subprocess.check_call(['rm', '-rf', REPO_PATH])
    subprocess.Popen(['sudo', 'fuser', '-k', '80/tcp', f'{PORT}/tcp'])


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

def _set_environment_variables_needed():
    os.environ["GROUP_NUMBER"] = "Equipo 09 - Marta Arcones & Teresa Charlo"
    # TODO setearla en el código de la aplicación

def _port_forwarding_setup_n_information():
    subprocess.Popen(['sudo', 'socat', 'tcp-listen:80,reuseaddr,fork', f'tcp:localhost:{PORT}'],
                          stdout=subprocess.DEVNULL,
                          stderr=subprocess.STDOUT)

    subprocess.check_call(['figlet', '\n\nbookstore app ready'])
    public_ip = subprocess.check_output(["curl", "-L", "ifconfig.me"]).decode("utf-8")

    print(
        f"\nAcceda a la aplicación en http://{public_ip}/productpage\n\n\n\n")


def _run_app():
    subprocess.call([sys.executable, 'productpage_monolith.py', f"{PORT}"])


if __name__ == "__main__":
    _cleanup_from_previous_executions()
    _clone_repo_and_go()
    _install_deps()
    _fix_deps()
    _set_environment_variables_needed()
    _port_forwarding_setup_n_information()
    _run_app()