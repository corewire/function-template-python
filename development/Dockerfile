FROM debian:12-slim AS build

RUN apt-get update \
    && apt-get install --no-install-recommends --yes python3-venv git inotify-tools 

# Don't write .pyc bytecode files.
ENV PYTHONDONTWRITEBYTECODE=true

# Dev dependencies.
WORKDIR /build
RUN python3 -m venv /venv/build \
    && /venv/build/bin/pip install hatch \
    && ln -s /venv/build/bin/hatch /usr/local/bin/hatch

COPY development/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]