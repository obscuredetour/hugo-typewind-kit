# Use the official Node.js image
FROM node:18

# Install dependencies needed for Hugo
RUN apt-get update && \
    apt-get install -y wget ca-certificates && \
    wget https://github.com/gohugoio/hugo/releases/download/v0.135.0/hugo_extended_0.135.0_linux-arm64.deb && \
    dpkg -i hugo_extended_0.135.0_linux-arm64.deb && \
    rm hugo_extended_0.135.0_linux-arm64.deb && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy package.json, package-lock.json, and tsconfig.json
COPY package.json package-lock.json tsconfig.json ./

# Install dependencies using npm
RUN npm ci

# Copy the rest of the application files
COPY . .

# Expose port 1313 for Hugo's development server
EXPOSE 1313

# Set the default command to run the development server
CMD ["npm", "run", "dev"]
