FROM ruby:2.6.2
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
 && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

WORKDIR /my_recipe_app

ADD Gemfile /my_recipe_app/Gemfile
ADD Gemfile.lock /my_recipe_app/Gemfile.lock
RUN bundle install

ENV APP_HOME /my_recipe_app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME