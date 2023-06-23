FROM python:3-alpine

ARG VERSION
RUN apk add build-base python3-dev && \
  python -m pip install --upgrade pip wheel && \
  python -m pip install httpie==${VERSION} && \
  apk del build-base python3-dev

ENTRYPOINT [ "http" ]
CMD ["--help"]
