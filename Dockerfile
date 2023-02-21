FROM node:16
WORKDIR /api
COPY package*.json ./index.js ./dbconnector.js ./
COPY ./routes/core.js ./routes/users.js  ./routes/
COPY ./utils/jwt-helper.js ./utils/authorization.js ./utils/
RUN npm install 
EXPOSE 3000
CMD ["node", "index.js"]