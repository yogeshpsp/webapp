FROM node
WORKDIR /usr/src/app
COPY dist/ .
EXPOSE 4200
CMD [ "npm","start" ]