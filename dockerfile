# Use official Node.js Alpine image
FROM node:18-alpine

# Install build tools
RUN apt-get update && apt-get install -y \
  python3 \
  make \
  g++ \
  && ln -sf python3 /usr/bin/python

# Install git, openssh-client (for ssh and scp)
RUN apk add --no-cache git openssh-client bash

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Set working directory inside container
WORKDIR /app

# Copy project files (optional, can be done by Jenkins checkout)
# COPY . .

# Default command to keep container alive or run shell
CMD ["sh", "npm", "start"]


