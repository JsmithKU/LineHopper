FROM node:16
WORKDIR /api
COPY package*.json ./index.js ./queries.js ./dbconnector.js ./
RUN npm install 
EXPOSE 3000
CMD ["node", "index.js"]