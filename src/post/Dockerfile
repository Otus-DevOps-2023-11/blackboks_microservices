FROM python:3.6.15-alpine
WORKDIR /app
COPY . /app
RUN apk update \
 && apk --no-cache add gcc musl-dev linux-headers curl &&  pip install -r /app/requirements.txt
ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts
ENTRYPOINT ["python3","post_app.py"]
