# We are using a different base image compared to the primer.
# In the primer ww used a lightweight version of Linux called Alpine Linux.
# In this container we will use the python base container which means that 
# python is already installed in the container. 
FROM python:3.10-slim-buster

WORKDIR /app

COPY * .

EXPOSE 9000

CMD ["./start.sh"]

