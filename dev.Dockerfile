FROM ruby:2.7.1

RUN apt-get update -qq
RUN apt-get install -y build-essential graphviz

# rails-credentials
RUN apt-get install -y nano
# simplecov
RUN apt-get install -y cmake

ENV APP_HOME=/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV EDITOR=nano

EXPOSE 3000
