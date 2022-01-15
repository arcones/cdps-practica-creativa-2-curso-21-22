from git import Repo
import subprocess
import sys
import os

URL = "https://github.com/CDPS-ETSIT/practica_creativa2.git"
REPO_PATH = f"{os.getcwd()}/app"


def _cleanup_from_previous_executions():
    subprocess.check_call(['rm', '-rf', REPO_PATH])
    subprocess.Popen(['sudo', 'fuser', '-k', '80/tcp', '9080/tcp'])


def _clone_repo_and_go():
    print(REPO_PATH)
    Repo.clone_from(URL, REPO_PATH)
    os.chdir(f"{REPO_PATH}/bookinfo/src/productpage")


def _install_deps():
    subprocess.check_call([sys.executable, '-m', 'pip', '--version'])
    subprocess.check_call(
        [sys.executable, '-m', 'pip', 'install', '-r', 'requirements.txt'])


def _set_environment_variables_needed():
    os.environ["GROUP_NUMBER"] = "Equipo 09 - Marta Arcones & Teresa Charlo"
    # TODO setearla en el código de la aplicación


def _port_forwarding_setup_n_information():
    subprocess.Popen([
        'sudo', 'socat', 'tcp-listen:80,reuseaddr,fork', 'tcp:localhost:9080',
        '&'
    ])

    public_ip = subprocess.check_output(["curl", "ifconfig.me"])
    public_ip_get_command = "curl ifconfig.me | cat"
    execution = subprocess.Popen(public_ip_get_command,
                                 shell=True,
                                 stdout=subprocess.PIPE,
                                 stderr=subprocess.STDOUT)
    public_ip = execution.communicate()[0]

    print(
        f"\n\n\n\nAcceda a la aplicación en http://{public_ip}/productpage\n\n\n\n"
    )

def _run_app():
    subprocess.Popen([sys.executable, 'productpage_monolith.py', '9080'],
                     stdout=subprocess.DEVNULL,
                     stderr=subprocess.STDOUT)


if __name__ == "__main__":
    _cleanup_from_previous_executions()
    _clone_repo_and_go()
    _install_deps()
    _set_environment_variables_needed()
    _port_forwarding_setup_n_information()
    _run_app()