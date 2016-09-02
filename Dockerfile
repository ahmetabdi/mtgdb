FROM ruby:2.3-slim
MAINTAINER ahmet@kyan.com
ENV REFRESHED_AT 2016-07-27

# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  ruby-dev \
  libgdbm-dev \
  libncurses5-dev \
  libffi-dev \
  libyaml-dev \
  libreadline-dev \
  libpq-dev \
  nodejs \
  git \
  && rm -rf /var/lib/apt/lists/*

# Setup app location
RUN mkdir -p /app
WORKDIR /app

# Install gems
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
