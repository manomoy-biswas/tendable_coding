FROM ruby:2.7.3-slim
RUN apt-get update -qq && apt-get install -y build-essential
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY . /app
CMD ["sh", "/app/run.sh"]

