FROM node:alpine as mybuilder
RUN mkdir -p /code
WORKDIR /code
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
RUN CI=true npm run test
CMD ["npm", "run", "start"]

FROM nginx
COPY --from=mybuilder ./code/build /usr/share/nginx/html

