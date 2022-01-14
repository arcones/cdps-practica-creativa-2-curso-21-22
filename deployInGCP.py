#!/usr/bin/python3

from git import Repo

URL = "https://github.com/CDPS-ETSIT/practica_creativa2.git"

Repo.clone_from(URL, "app")