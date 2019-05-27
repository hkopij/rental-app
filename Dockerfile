FROM ruby:2.5.1

RUN apt-get update -qq &&              \
    apt-get install -y --allow-unauthenticated build-essential \
                       libpq-dev       \
                       libxml2-dev libxslt1-dev \
                       libqtwebkit4 libqt4-dev xvfb \
                       nodejs

ENV APP_HOME /hertz
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY . .

RUN bundle install

ADD . $APP_HOME
