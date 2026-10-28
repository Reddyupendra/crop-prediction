# Crop Recommendation System

A Django-based machine learning project for exploring crop recommendations from agricultural data. The repository includes a crop recommendation dataset, a serialized model, and a web application with user-facing workflows.

## Project overview

The project demonstrates how a web application can connect a machine learning model to an interactive interface. It includes a Django project, application templates/static assets, a dataset, and a model artifact.

### Repository structure

- `crop_predication_chatbot/` — Django project settings and URL routing
- `home/` — primary application code, views, models, and forms
- `admins/` — custom admin-facing workflows
- `templates/` and `static/` — web interface assets
- `Crop_recommendation.csv` — dataset used by the project
- `crop_model.pkl` — serialized model artifact
- `build.sh` — build/deployment script
- `requirements.txt` — Python dependencies

## Features represented in the current code

- Django web application
- User registration and login workflow
- Admin-facing user management workflow
- Crop-model training/prediction and dataset views
- Crop recommendation dataset and a stored model artifact

Feature availability and behavior may depend on configuration. The application has not been independently tested as part of this documentation update, so no performance or accuracy claims are made here.

## Technology stack

- Python 3.10
- Django 5.2
- Django REST Framework
- pandas, scikit-learn, matplotlib, seaborn
- SQLite for local development
- Gunicorn and WhiteNoise for deployment support

## Run locally

### 1. Clone the repository

```bash
git clone https://github.com/Reddyupendra/crop-prediction.git
cd crop-prediction
```

### 2. Create and activate a virtual environment

**Windows PowerShell**

```powershell
py -3.10 -m venv .venv
.\.venv\Scripts\Activate.ps1
```

**macOS/Linux**

```bash
python3.10 -m venv .venv
source .venv/bin/activate
```

### 3. Install dependencies

```bash
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

### 4. Configure environment variables

Copy the example file to `.env`:

**Windows PowerShell**
```powershell
Copy-Item .env.example .env
```

**macOS/Linux**
```bash
cp .env.example .env
```

Generate a new Django secret key:

```bash
python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

Put the generated value in `DJANGO_SECRET_KEY` in your local `.env` file. Do not commit `.env`. If you use the custom admin login workflow, set a strong `ADMIN_LOGIN_ID` and `ADMIN_PASSWORD` locally; leave these unset to keep that login disabled.

### 5. Initialize and run Django

```bash
python manage.py migrate
python manage.py check
python manage.py runserver
```

Open http://127.0.0.1:8000/ in your browser.

The Django development server is for local development only. Do not use it as a production server.

## Configuration

The project reads local settings from `.env` and environment variables. Relevant settings include:

| Variable | Purpose |
|---|---|
| `DJANGO_SECRET_KEY` | Required Django secret key |
| `DJANGO_DEBUG` | Enables debug mode only for local development |
| `DJANGO_ALLOWED_HOSTS` | Comma-separated allowed hostnames |
| `EMAIL_HOST_USER` | Optional SMTP account |
| `EMAIL_HOST_PASSWORD` | Optional SMTP password/app password |
| `ADMIN_LOGIN_ID` | Optional custom admin login ID |
| `ADMIN_PASSWORD` | Optional custom admin password |

For a hosted deployment, configure these in the hosting provider's environment settings. Use `DJANGO_DEBUG=False`, a new secret key, and exact hostnames. Never deploy using development credentials.

## Security notes — read before deploying

**Credentials were found hard-coded in the original project settings. Treat them as compromised.** The settings file has been changed to read secrets from environment variables, but changing the latest file does not erase previous Git history.

- Revoke and rotate the email app password that was committed to the repository.
- Generate a new Django secret key and set `DJANGO_SECRET_KEY` in your environment.
- The custom registration model previously stored passwords in plain text. New registrations now use Django password hashing, and the login view upgrades a legacy plain-text password to a hash when that account next logs in. Existing database files may still contain personal data or old password fields; the repository database has been removed from the latest revision, but its historical Git objects may remain.
- The custom admin workflow now requires environment credentials and does not use the old hard-coded default. It is still a custom authentication flow, not a replacement for Django's full staff-user authorization system.
- Do not expose this application to the public internet until authentication, authorization, CSRF protections, and deployment settings have been reviewed and tested.
- Never upload real user data, local database files, secrets, or private profile images.

See [SECURITY.md](SECURITY.md) for a checklist.

## Model and data notes

Only load trusted `crop_model.pkl` files. Python pickle-based model artifacts can execute code when loaded if the file is malicious. Verify that the model's expected feature order and package versions match the application before relying on predictions.

No accuracy score or agricultural advice guarantee is claimed in this README. Add metrics only after evaluating the model on a held-out test set and documenting the evaluation method.

## Deployment notes

The repository includes `build.sh` for installing dependencies, collecting static files, and applying database migrations. Configure a new secret key, `DJANGO_DEBUG=False`, allowed hosts, email credentials if needed, and a persistent database/media strategy before deploying.

The project currently uses SQLite in settings. For a multi-user hosted deployment, choose an appropriate persistent database and configure user-uploaded media storage explicitly.

## Next improvements

- Add automated tests for registration, access control, prediction input validation, and key views.
- Move custom admin access to Django's built-in authentication and staff permissions.
- Document the model training procedure, feature schema, train/test split, evaluation metrics, and known limitations.
- Add screenshots and a short demo after verifying the application locally.
- Add continuous integration once the test suite is in place.

## License

No license is currently specified. Add a license if you intend to grant others permission to reuse or modify this project.
