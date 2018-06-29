FROM ruby:alpine

RUN adduser -s /bin/sh -u 1001 -G root -h /app -S -D rails \
    && chown -R rails /app

RUN apk add --update --no-cache postgresql-dev
WORKDIR /app

COPY Gemfile* /app/

RUN apk add --update --no-cache --virtual build-base libxml2-dev libxslt-dev  && \
    bundle install --jobs 4  --without test development && \
    apk del build-base libxml2-dev libxslt-dev


ADD . /app

RUN chown -R rails /app

USER rails

ENV RAILS_ENV production

CMD ["bin/rails", "s", "-b", "0.0.0.0", "-p", "${PORT}"]
