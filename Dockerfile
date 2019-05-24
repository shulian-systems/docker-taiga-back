FROM python:3.6-alpine
MAINTAINER Shulian Systems "contact@shulian.systems"

RUN mkdir /app
WORKDIR /app
RUN apk add --no-cache git gcc musl-dev libffi-dev libxml2-dev libxslt-dev postgresql-dev jpeg-dev
RUN git clone https://github.com/taigaio/taiga-back.git .

RUN pip install -r requirements.txt

RUN apk del git gcc postgresql-dev

RUN addgroup --gid 199 -S taiga && adduser -u 199 -S taiga -G taiga
RUN chown -R taiga:taiga /app
USER taiga

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
