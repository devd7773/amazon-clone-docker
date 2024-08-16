# Use the official Node.js 16 image as the base image
FROM node:latest as builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the React app
RUN npm run build

FROM nginx:latest

COPY --from=builder /app/build/ /usr/share/nginx/html/
