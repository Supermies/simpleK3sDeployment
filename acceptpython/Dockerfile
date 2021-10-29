FROM python:3.6-alpine

RUN pip3 install flask

COPY ./app /pythonapp
WORKDIR /pythonapp
EXPOSE 5000

CMD ["python", "app.py"]  