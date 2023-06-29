#!/bin/bash
set -x
if ( ls | grep "db.sqlite3" );
then
	python3 manage.py runserver 0.0.0.0:5000
else
	python3 manage.py makemigrations
	python3 manage.py migrate
	python3 manage.py runserver 0.0.0.0:8000
fi
