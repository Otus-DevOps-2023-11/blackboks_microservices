FROM alpine:3.14
RUN apk update \
 && apk --no-cache add ruby-full ruby-dev build-base \
 && gem install bundler -N  -v '1.17.2'
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle update --bundler; bundle install
COPY . $APP_HOME

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
