#!/bin/bash

if python --version | grep 3.7.7; then
    echo "Already installed"
else
    echo "Installing specific python version"
    pyenv install 3.7.7 && pyenv global 3.7.7
fi

pip install -r requirements.txt && python setupNLaunchBookStore.py