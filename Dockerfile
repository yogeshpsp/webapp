FROM node 
WORKDIR /usr/src/app
COPY . .
RUN npm install -g @angular/cli
RUN npm install
RUN npm run build
EXPOSE 4200
CMD [ "ng", "serve" ]
