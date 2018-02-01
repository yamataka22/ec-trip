FROM ruby:2.4.1
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
  build-essential \
  wget \
  git-core \
  libxml2 \
  libxml2-dev \
  libxslt1-dev \
  nodejs \
  nodejs-legacy \
  npm \
  imagemagick \
  libmagickcore-dev \
  libmagickwand-dev \
  libpq-dev \
  vim \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /ec-trip
WORKDIR /ec-trip
ADD Gemfile /ec-trip/Gemfile
ADD Gemfile.lock /ec-trip/Gemfile.lock
RUN bundle install
ADD . /ec-trip
