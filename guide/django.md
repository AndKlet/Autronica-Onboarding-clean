# Django guide

## Installation

For local development use virtual environment to install dependencies. To install venv run:

```bash
sudo pip install virtualenv
```

To create a virtual environment run:

```bash
python -m venv .venv
```

To activate the virtual environment run:

On macOS and Linux:

```bash
source .venv/bin/activate
```

On Windows (git bash):

```bash
source .venv/Scripts/activate
```

To install the dependencies run:

```bash
pip install -r requirements.txt
```

After installing tset up pre-commit hooks by running:

```bash
pre-commit install
```

now every time you commit, the pre-commit hooks will run and check for any errors and linting that need to be fixed.

To deactivate the virtual environment run:

```bash
deactivate
```

If you use a new dependency, make sure to update the requirements.txt file by running (make sure to activate the virtual environment or else everyone will get all your glo):

```bash
pip freeze > requirements.txt
```

## Structure

In Django, a project is a collection of applications and configurations. An application is a collection of views, models, and templates that are used to perform a specific task.For our usecase we will have a single application that will contain all the logic for the project.

We will be using Django mainly for the backend, for task such as authentication, data storage and API calls.

Therefore the structure of the project will be as follows:

```bash
autron
    ├── autron
    │   ├── asgi.py
    │   ├── __init__.py
    │   ├── models.py
    │   ├── serializers.py - Contains the serializers for the models
    │   ├── settings.py - Contains the settings for the project
    │   ├── urls.py - Contains the urls for the application which then point to the views
    │   ├── views.py - Contains the api views for the application
    │   └── wsgi.py
    ├── db.sqlite3
    ├── docker-compose.yml - file to run the project with docker
    ├── Dockerfile - file to build the image
    ├── manage.py
    └── requirements.txt
```

## Build and run the project

We will be building and deploying Django with Docker. This will ensure it runs the same on all machines and will make it easier to deploy. For instructions on how to install Docker, see [here](https://docs.docker.com/get-docker/).

Rebuild the image and run the container (run from root of backend directory):

```bash
docker compose up -d --build
```

-d flag is used to run the container in detached mode.

--build flag is used to rebuild the image.

The server will be running at `localhost:8000`.

Additionally, the admin panel will be available at `localhost:8000/admin`.

And Swagger documentation will be available at `localhost:8000/swagger`.

To stop the container:

```bash
docker compose down
```

To see the logs of the container:

```bash
docker compose logs
```

## Usefull commands

If you want to run a command inside the container, you can add the following to the command:

```bash
docker compose exec autron <command>
```

Otherwise you can run the command from the root of the backend directory when running django on your local machine.
Run server

```bash
python manage.py runserver
```

When making changes to the models, run the following commands to apply the changes to the database:

```bash
python manage.py makemigrations
python manage.py migrate
```

Create superuser to access the admin panel at `localhost:8000/admin`

```bash
python manage.py createsuperuser
```
