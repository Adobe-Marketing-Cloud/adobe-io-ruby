FROM ruby:2.4.1

RUN apt-get update && apt-get install -y vim less
WORKDIR /srv/ruby-adobe-io

CMD bash
