# Dockerfile for frontend application

# Use the official Node.js Alpine image
FROM node:16

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the source code to the working directory
COPY . .

# Expose the port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]