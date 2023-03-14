# The first line in the Dockerfile specifies a base image to use. This image 
# containts a the run time to execute the and store files.
# In our case we will use a lightweight version of Linux called Alpine Linux.
FROM alpine:3.14

# The WORKDIR command specifies the directory in the container where files are stored.
WORKDIR /my-app

# With RUN we can execute a (shell) command in the container.
# In the next line we create a file called 'who.who'
RUN touch who.who

# In this line we run a script and store the results in the previously created file.
RUN echo "Hello $(whoami)" > who.who

# Lastly we run the docker CMD command. This is used to execute an application in the
# container. Should be done as last command.
# In our case we want to display the contents of our previously created file.
CMD [ "cat", "who.who" ]