# Use Ubuntu base image which is pulled from container registry.
FROM ubuntu:22.04

# Update packages and install nginx, zip and curl.
RUN apt-get update
RUN apt-get install -y nginx zip curl

# Run nginx on foreground 1 container: 1 process
RUN echo "daemon off;" >>/etc/nginx/nginx.conf
# Curl repository to download all files for the 2048 game
RUN curl -o /var/www/html/master.zip -L https://codeload.github.com/gabrielecirulli/2048/zip/master
# Change directory and unzip downloaded files for the 2048 game to current path then delete the downloaded zip for 2048 game.
RUN cd /var/www/html/ && unzip master.zip && mv 2048-master/* . && rm -rf 2048-master master.zip

# Specifies the port to be exposed for the Docker container.
EXPOSE 80

# Start nginx server with specified config.
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]