FROM python:3.6-alpine
MAINTAINER Shulian Systems "contact@shulian.systems"

RUN mkdir /app
WORKDIR /app
RUN apk add --no-cache git gcc gettext musl-dev libffi-dev libxml2-dev libxslt-dev postgresql-dev jpeg-dev
RUN git clone https://github.com/taigaio/taiga-back.git .

RUN pip install -r requirements.txt
RUN pip install taiga-contrib-ldap-auth-ext
RUN python manage.py compilemessages

RUN apk del git gcc gettext

RUN addgroup --gid 1999 -S taiga && adduser -u 1999 -S taiga -G taiga
RUN chown -R taiga:taiga /app
USER taiga

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
