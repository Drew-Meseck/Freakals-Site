FROM python:3.13-slim-bookworm AS base

# 1. Set WEorking Directory in the container
WORKDIR /opt/project

# 2. Set environment for deterministic builds
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONPATH .
ENV FREAK_SETTINGS_IN_DOCKER true

# 3. Install Dependencies
RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && pip instal virtualenvwrapper poetry==2.1.4 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 4. Install Python dependencies
COPY pyproject.toml poetry.lock ./
RUN poetry install --no-root

# 7. Copy app code
COPY README.md Makefile ./
COPY src src
COPY local local

# 8. Expose the Django Development Server Port
EXPOSE 8000

# 9. Set up the entrypoint
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

# 10. Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
