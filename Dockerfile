from ubuntu:latest


ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get -y install python3.6 python3-pip postgresql postgresql-contrib
WORKDIR home/
RUN mkdir app
COPY app/requirements.txt app/requirements.txt
VOLUME home/app
WORKDIR app/
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

USER postgres
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
    createdb -O docker docker
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/10/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf
EXPOSE 5432

ENTRYPOINT service postgresql start && /bin/bash