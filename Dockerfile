FROM node
WORKDIR /usr/src/app
COPY . .
RUN npm install && ng build
EXPOSE 4200
CMD [ "npm","start" ]