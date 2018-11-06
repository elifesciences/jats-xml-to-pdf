#!/bin/bash
if [ ! -d venv ]; then
    python3 -m venv venv
    source venv/bin/activate
    pip install pandocfilters
    exit 0
fi
source venv/bin/activate
python abstract.py
