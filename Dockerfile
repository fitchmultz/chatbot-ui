# Use the official Node.js 16 image as a parent image
FROM node:21

# Install necessary dependencies for Supabase CLI
RUN apt-get update && apt-get install -y curl ca-certificates gnupg

# Install Supabase CLI
RUN curl -sL https://cli.supabase.io/install.sh | sh -e

# Check if Supabase CLI is installed and in PATH
RUN supabase --version

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (or alternatively yarn.lock)
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of your app's source code from your host to your image filesystem
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Make the start script executable
COPY ./docker-start.sh /usr/src/app/docker-start.sh
RUN chmod +x /usr/src/app/docker-start.sh

# Start the app and Supabase
CMD ["/usr/src/app/docker-start.sh"]
