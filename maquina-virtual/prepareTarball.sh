#!/bin/bash

rm -rf cdps-pc2.tar.gz && tar -zcvf cdps-pc2.tar.gz \
    setupNLaunchBookStore.py requirements.txt setupVM.sh runBookStore.sh