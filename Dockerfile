FROM ruby:2.5.1

RUN apt-get update && apt-get install -y vim less
WORKDIR /srv/adobe-io-ruby

CMD bash
