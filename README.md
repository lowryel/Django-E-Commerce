# E-Commerce Project For Baby Tools
### TECHNOLOGIES
- Python
- Django
- Venv


### Photos

##### Home Page with login
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080815407.jpg"></img>
##### Home Page with filter
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080840305.jpg"></img>
##### Product Detail Page
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080934541.jpg"></img>

##### Home Page with no login
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080953570.jpg"></img>


##### Register Page
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081016022.jpg"></img>


##### Login Page
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081044867.jpg"></img>

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

# upgrade pip to latest version
RUN pip install --upgrade pip

RUN pip install -r requirements.txt --cache-dir /app/pip_cache

# Running a multi-stage build to reduce the final image size
FROM python:3.10-alpine

# Working dir for stage 2
WORKDIR /babyshop-app

ENV PATH="/opt/venv/bin:$PATH"

# Copy requirements file from local app directory
COPY --from=Builder /app/ /babyshop-app/

RUN ls /babyshop-app

# upgrade pip to latest version
RUN pip install --upgrade pip

# Assign user to the directory
# RUN useradd -ms /bin/bash www-data

# USER www-data

# Install dependencies
RUN pip install -r requirements.txt

# Expose the necessary port for action
EXPOSE 8000

# Set the start up command
CMD [ "python3 manage.py makemigrations", "python3 manage.py migrate", "python3 manage.py runserver" ]

