FROM python:3.11

RUN mkdir /app

WORKDIR /app

COPY requirements.txt /app
RUN pip install -r requirements.txt

COPY . /app

CMD ["sh", "-c", "python manage.py runserver 0.0.0.0:8000 --settings=autron.settings_${DJANGO_ENV}"]
