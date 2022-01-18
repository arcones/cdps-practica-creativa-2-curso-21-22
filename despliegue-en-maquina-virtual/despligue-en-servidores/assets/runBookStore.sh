#!/bin/bash

if python --version | grep 3.7.7; then
    echo "Already installed"
else
    echo "Installing specific python version"
    pyenv install 3.7.7 && pyenv global 3.7.7
fi

if [ $# -eq 0 ]; then
    echo -e "\n\n\nThe port has not been specified so the app will run on default one, 9080\n\n\n"
    pip install -r requirements.txt && python setupNLaunchBookStore.py
else
    pip install -r requirements.txt && python setupNLaunchBookStore.py --port $1
fi
