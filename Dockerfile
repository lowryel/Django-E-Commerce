FROM python:3.9-alpine3.17 as Builder

# Setting environment variables. (Good Practice)
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the current working directory
WORKDIR /app

RUN mkdir -p /app/pip_cache

# Copy the django project
COPY /babyshop_app/* /app

RUN pip install -r requirements.txt --cache-dir /app/pip_cache

# Running a multi-stage build to reduce the final image size
FROM python:3.9-alpine3.17

# Working dir for stage 2
WORKDIR /babyshop-app

# Copy requirements file from local app directory
COPY --from=Builder requirements.txt /babyshop-app

# upgrade pip to latest version
RUN pip install --upgrade pip

# Install dependencies
RUN pip install -r requirements.txt

# Copying the pre-built app from stage 1
COPY --from=Builder /app/ /babyshop-app

# Assign user to the directory
RUN chown -R www-data:www-data /babyshop-app
USER www-data

# Expose the necessary port for action
EXPOSE 8000

# Set the start up command
CMD [ "start-server.sh"]
