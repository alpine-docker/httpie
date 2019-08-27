FROM alpine:edge

RUN apk add --update --no-cache python3 && \
    pip3 install --upgrade pip setuptools httpie && \
    rm -r /root/.cache

ENTRYPOINT [ "http" ]
CMD ["--help"]
