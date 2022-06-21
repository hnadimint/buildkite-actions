FROM python:3.6-slim-buster

USER root

WORKDIR /app

COPY requirements.txt requirements.txt
RUN yum install pip3
RUN pip3 install -r requirements.txt

COPY app.py app.py

RUN groupadd -r app-admin -g 1000 && \
    useradd -u 1000 -r -g app-admin -s /sbin/nologin -c "Docker image user" app-admin

USER app-admin

CMD [ "python", "-m" , "flask", "run", "--host=0.0.0.0"]
