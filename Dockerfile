FROM ruby:2.7.1

RUN apt-get update -qq
RUN apt-get install -y build-essential

ENV APP_HOME=/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

COPY . .

ENV RAILS_ENV=production

EXPOSE 3000
