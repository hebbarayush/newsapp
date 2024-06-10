FROM node:16 AS build

WORKDIR /app

Copy package.json and package-lock.json
COPY package*.json ./

RUN npm install

Copy the rest of the application source code
COPY . .

RUN npm run build

FROM nginx:alpine

Copy the build output from the first stage to the Nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

Copy custom Nginx configuration file (if any)
COPY nginx.conf /etc/nginx/nginx.conf

Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
