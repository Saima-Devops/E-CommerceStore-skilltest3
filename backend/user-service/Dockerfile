FROM node:18-alpine

# Create application directory
WORKDIR /app

# Copy package files first for better layer caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source
COPY . .

# Create a non-root user and group
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup && \
    chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose application port
EXPOSE 3001

# Start the application
CMD ["npm", "start"]
