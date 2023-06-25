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
RUN pip install --upgrade pip 
RUN pip install -r requirements.txt --cache-dir /app/pip_cache

# Expose the necessary port for action
EXPOSE 8000

# Set the start up command
CMD [ "./start-server.sh" ]
