FROM python:3.10-slim-buster

COPY simple-todo-backend /app
WORKDIR /app

EXPOSE 80

RUN pip install --upgrade pip && \
    pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install

RUN cd /app
RUN poetry install

CMD poetry run python3 app.py