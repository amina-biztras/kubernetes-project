# Use the official NGINX image from Docker Hub
FROM nginx:alpine

# Copy custom HTML files into the NGINX web directory
COPY ./html /usr/share/nginx/html

# Expose port 80 (default for NGINX)
EXPOSE 80
