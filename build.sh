#!/usr/bin/env bash
# exit on error
set -o errexit

pip install -r requirment.txt

# Ensure media folder exists and model is in it
mkdir -p media
cp crop_model.pkl media/

python manage.py collectstatic --no-input

python manage.py migrate
