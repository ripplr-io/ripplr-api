FROM ruby:2.7.1

RUN apt-get update -qq
RUN apt-get install -y build-essential

# Only required in development
RUN apt-get install -y graphviz

ENV APP_HOME=/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock $APP_HOME/
RUN bundle install

COPY . $APP_HOME

EXPOSE 3000
