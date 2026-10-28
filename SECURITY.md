# Security policy and checklist

## Before deployment

- [ ] Revoke and rotate the email app password that was committed to the repository.
- [ ] Generate a new `DJANGO_SECRET_KEY`; keep it in environment variables.
- [ ] Set `DJANGO_DEBUG=False` and configure exact allowed hostnames.
- [ ] Configure SMTP secrets only in the hosting environment, never in source code.
- [ ] Review custom registration and login behavior, session handling, access controls, and CSRF protection.
- [ ] Migrate remaining plain-text legacy user passwords to Django's password hashing system and stop storing password confirmations.
- [ ] Replace the custom admin login with Django's built-in authentication, staff permissions, and protected POST actions before public deployment.
- [ ] Review the tracked SQLite database for personal data. The latest revision removes it, but older Git history may still contain its contents.
- [ ] Treat committed credentials as compromised even if the latest source has been edited. Rotate/revoke them at the provider; consider a carefully planned history rewrite if data exposure requires it.
- [ ] Load only trusted model pickle files.
- [ ] Run Django's deployment checks and automated tests.

## Reporting

For a real deployment, provide a private method for reporting security issues. Do not publish credentials, personal data, or exploit details in public issues.
