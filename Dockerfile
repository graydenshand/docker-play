FROM ubuntu:latest


RUN apt-get update
RUN apt-get -y install python3.6 python3-pip
WORKDIR home/
RUN mkdir app
COPY app/requirements.txt app/requirements.txt
VOLUME home/app
WORKDIR app/
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt