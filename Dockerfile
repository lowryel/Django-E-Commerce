FROM python:3.10-slim-buster as Builder

# Setting environment variables. (Good Practice)
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the current working directory
WORKDIR /app

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

ENV PATH="/usr/bin/python3:$PATH"

RUN mkdir -p /app/pip_cache

# Copy the django project
COPY /babyshop_app/ /app/

# upgrade pip to latest version and run & cache requirements
RUN pip install --upgrade pip &&
    pip install -r requirements.txt --cache-dir /app/pip_cache

# Running a multi-stage build to reduce the final image size
FROM python:3.10-alpine

# Working dir for stage 2
WORKDIR /babyshop-app

ENV PATH="/opt/venv/bin:$PATH"

# Copy requirements file from local app directory
COPY --from=Builder /app/ /babyshop-app/

ENV PATH="/opt/venv/bin:$PATH"

# upgrade pip to latest version
RUN pip install --upgrade pip

# Install dependencies
RUN pip install -r requirements.txt

# Expose the necessary port for action
EXPOSE 8000

# Set the start up command
CMD [ "./start-server.sh" ]

