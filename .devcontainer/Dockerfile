# References: 
# - https://github.com/squidfunk/mkdocs-material/blob/master/Dockerfile
# - https://github.com/titom73/docker-mkdocs/blob/master/Dockerfile

FROM python:3.9.2-alpine3.13


# Set build directory
WORKDIR /tmp

# Copy files necessary for build
COPY requirements.txt requirements.txt

# Perform build and cleanup artifacts and caches
RUN \
  apk upgrade --update-cache -a && \
  apk add --no-cache \
    git \
    git-fast-import \
    openssh \
  && apk add --no-cache --virtual .build gcc musl-dev \
  && pip install --no-cache-dir -r requirements.txt \
  && apk del .build gcc musl-dev \
  && rm -rf /tmp/* /root/.cache

# Set working directory
WORKDIR /docs

# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]