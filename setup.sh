#!/bin/bash
# use python3.10

python3.10 -m pip install --upgrade pip
python3.10 -m pip install -r requirements.txt
playwright install
python3.10 -m playwright install-deps
# python3 -m playwright install-deps
cd ui/
npm install
