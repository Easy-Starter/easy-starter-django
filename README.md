# Easy Starter Django (based on [Lithium](https://github.com/wsvincent/lithium))

## 🚀 Features

- Django 6.0 & Python 3.13
- Installation via [uv](https://github.com/astral-sh/uv), [Pip](https://pypi.org/project/pip/) or [Docker](https://www.docker.com/)
- User authentication--log in, sign up, password reset--via [django-allauth](https://github.com/pennersr/django-allauth)
- Static files configured with [Whitenoise](http://whitenoise.evans.io/en/stable/index.html)
- Styling with [Bootstrap v5](https://getbootstrap.com/)
- Debugging with [django-debug-toolbar](https://github.com/jazzband/django-debug-toolbar)
- DRY forms with [django-crispy-forms](https://github.com/django-crispy-forms/django-crispy-forms)
- Custom 404, 500, and 403 error pages

## Table of Contents

- **[Installation](#installation)**
  - [uv](#uv)
  - [Pip](#pip)
  - [Docker](#docker)
- [Next Steps](#next-steps)
- [Contributing](#contributing)
- [Support](#support)
- [License](#license)

## 📖 Installation

**Easy Starter Django** can be installed via Pip or Docker. To start, clone the repo to your local computer and change into the proper directory.

```
$ git clone https://github.com/Easy-Starter/easy-starter-django.git
$ cd easy-starter-django
```

### uv

You can use [uv](https://docs.astral.sh/uv/) to create a dedicated virtual environment.

```
$ uv sync
```

Then run `migrate` to configure the initial database. The command `createsuperuser` will create a new superuser account for accessing the admin. Execute the `runserver` command to start up the local server.

```
$ uv run manage.py migrate
$ uv run manage.py createsuperuser
$ uv run manage.py runserver
# Load the site at http://127.0.0.1:8000 or http://127.0.0.1:8000/admin for the admin
```

### Pip

To use Pip, create a new virtual environment and then install all packages hosted in `requirements.txt`. Run `migrate` to configure the initial database. and `createsuperuser` to create a new superuser account for accessing the admin. Execute the `runserver` command to start up the local server.

```
(.venv) $ pip install -r requirements.txt
(.venv) $ python manage.py migrate
(.venv) $ python manage.py createsuperuser
(.venv) $ python manage.py runserver
# Load the site at http://127.0.0.1:8000 or http://127.0.0.1:8000/admin for the admin
```

### Docker

To use Docker with PostgreSQL as the database update the `DATABASES` section of `easy_starter_django/settings.py` to reflect the following:

```python
# easy_starter_django/settings.py
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "postgres",
        "USER": "postgres",
        "PASSWORD": "postgres",
        "HOST": "db",  # set in docker-compose.yml
        "PORT": 5432,  # default postgres port
    }
}
```

The `INTERNAL_IPS` configuration in `easy_starter_django/settings.py` must be also be updated:

```python
# config/settings.py
# django-debug-toolbar
import socket
hostname, _, ips = socket.gethostbyname_ex(socket.gethostname())
INTERNAL_IPS = [ip[:-1] + "1" for ip in ips]
```

And then proceed to build the Docker image, run the container, and execute the standard commands within Docker.

```
$ docker compose up -d --build
$ docker compose exec web python manage.py migrate
$ docker compose exec web python manage.py createsuperuser
# Load the site at http://127.0.0.1:8000 or http://127.0.0.1:8000/admin for the admin
```

## Next Steps

- Add environment variables. There are multiple packages but I personally prefer [environs](https://pypi.org/project/environs/).
- Add [gunicorn](https://pypi.org/project/gunicorn/) as the production web server.
- Update the [EMAIL_BACKEND](https://docs.djangoproject.com/en/4.0/topics/email/#module-django.core.mail) and connect with a mail provider.
- Make the [admin more secure](https://opensource.com/article/18/1/10-tips-making-django-admin-more-secure).
- `django-allauth` supports [social authentication](https://django-allauth.readthedocs.io/en/latest/socialaccount/index.html) if you need that.

I cover all of these steps in tutorials and premium courses over at [LearnDjango.com](https://learndjango.com).

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## ⭐️ Support

Give a ⭐️ if this project helped you!

## Create new repo from the template

- change all the easy_starter_django in the project
- Ctrl + Shift + F -> search "easy_starter_django" -> replace all with Ctrl + Shift + H
- remove .env track from git

```bash
git rm --cached -- .env.*
```

## Packages

```bash
pip install django-environ dj_database_url psycopg
```

## Formatter

- Black

## Environment Variable Setup for Terminal

- Create new SECRET_KEY and put it in your .env files

‍‍‍```bash
python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"

````

- Add .env.* to .gitignore

```bash
export DJANGO_ENV=dev  # for running on local server
````

## Database

- Default DB = PostgreSQL
- Fallback DB = SQLite

### Setup Local PostgreSQL

```bash
sudo -u postgres psql  # Run psql


CREATE USER myuser WITH PASSWORD 'mypassword';  # Create new user

CREATE DATABASE mydb OWNER myuser;  # Create new DB

\q  # Quit psql
```

- DB URL pattern to use as a DATABSE_URL env variable value:

postgresql://{env('DB_USER')}:{env('DB_PASSWORD')}@localhost:5432/{env('DB_NAME')}

- Apply migrations

```bash
ptyhon manage.py migrate
```

## API

### Success

```json
{
  "success": true,
  "message": "ثبت‌نام با موفقیت انجام شد.",
  "data": {}
}
```

### Failed

```json
{
  "success": false,
  "code": "USER_NOT_FOUND",
  "message": "کاربری با این شماره موبایل وجود ندارد.",
  "errors": null
}
```
