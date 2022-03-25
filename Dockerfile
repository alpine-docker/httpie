FROM python:3-alpine

ARG VERSION
RUN  python -m pip install --upgrade pip wheel httpie==${VERSION}

ENTRYPOINT [ "http" ]
CMD ["--help"]
