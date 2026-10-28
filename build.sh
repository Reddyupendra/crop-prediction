#!/usr/bin/env bash
# exit on error
set -o errexit

python -m pip install --upgrade pip
python -m pip install -r requirements.txt

# Ensure media folder exists and model is in it
mkdir -p media
cp crop_model.pkl media/
cp Crop_recommendation.csv media/

python manage.py collectstatic --no-input

python manage.py migrate
