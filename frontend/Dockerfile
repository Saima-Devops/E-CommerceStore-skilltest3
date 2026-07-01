FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Give ownership of the application files to the non-root user
RUN chown -R node:node /app

# Run the application as a non-root user
USER node

EXPOSE 3000

CMD ["npm", "start"]
