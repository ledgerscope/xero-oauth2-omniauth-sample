FROM ruby:2.7.0-slim-buster

RUN apt update
RUN apt install nodejs npm -y
RUN apt-get install libsqlite3-dev

RUN npm install -g yarn
RUN apt install nano

### To Aid Fiddler Debugging
# ADD FiddlerRoot.crt /usr/local/share/ca-certificates/FiddlerRoot.crt
# RUN chmod 644 /usr/local/share/ca-certificates/FiddlerRoot.crt && update-ca-certificates

# ENV http_proxy "http://host.docker.internal:8888/"
# ENV https_proxy "http://host.docker.internal:8888/"