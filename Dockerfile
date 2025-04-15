# Use an official Node.js image
FROM node:18

# Create and set working directory
WORKDIR /usr/src/app

# Copy dependency definitions
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy app source
COPY . .

# App listens on port 3000
EXPOSE 3000

# Run the app
CMD ["node", "app.js"]
