FROM python:3.9-alpine3.13
LABEL maintainer="londonappdeveloper.com"

ENV PYTHONBUFFERED 1
COPY  ./requirements.txt /requirements.txt
COPY ./app app
COPY ./scripts /scripts

WORKDIR /app

EXPOSE 8000

# All the commands are in one line
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev linux-headers && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home app && \
    mkdir -p /vol/static && \
    mkdir -p /vol/web/media && \
    chown -R app:app /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts

# When we run python command in the system there is no need to run the /py/bin
ENV PATH="/scripts:/py/bin:$PATH"

# Anything we run after this line we run with USER no root user
USER app

CMD ["run.sh"]
