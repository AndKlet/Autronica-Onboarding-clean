# Django guide

## Installation
For local development, you can install Django using pip.

```bash
pip install django
```

## Structure

In Django, a project is a collection of applications and configurations. An application is a collection of views, models, and templates that are used to perform a specific task.For our usecase we will have a single application that will contain all the logic for the project.

We will be using Django mainly for the backend, for task such as authentication, data storage and API calls.

Therefore the structure of the project will be as follows:

```
autron
    ├── autron
    │   ├── asgi.py
    │   ├── __init__.py
    │   ├── models.py - Contains the models for the application
    │   ├── settings.py - Contains the settings for the project
    │   ├── urls.py - Contains the urls for the application which then point to the views
    │   ├── views.py - Contains the api views for the application
    │   └── wsgi.py    
    └── manage.py
```

## Build and run the project

We will be building and deploying Django with Docker. This will ensure it runs the same on all machines and will make it easier to deploy. For instructions on how to install Docker, see [here](https://docs.docker.com/get-docker/).

Rebuild the image and run the container (run from root of backend directory):

```bash
docker-compose up -d --build
```

-d flag is used to run the container in detached mode.
--build flag is used to rebuild the image.

To stop the container:

```bash
docker-compose down
```

To see the logs of the container:

```bash
docker-compose logs
```

## Usefull commands

Run server

```bash
manage.py runserver
```

When making changes to the models, run the following commands to apply the changes to the database:

```bash
manage.py makemigrations
manage.py migrate
```

Create superuser to access the admin panel at `localhost:8000/admin`

```bash
manage.py createsuperuser
```
