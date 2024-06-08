Stage 1: Build the React application
FROM node:16 AS build

Set the working directory
WORKDIR /app

Copy package.json and package-lock.json
COPY package*.json ./

Install dependencies
RUN npm install

Copy the rest of the application source code
COPY . .

Build the React application
RUN npm run build

Stage 2: Serve the React application with Nginx
FROM nginx:alpine

Copy the build output from the first stage to the Nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

Copy custom Nginx configuration file (if any)
COPY nginx.conf /etc/nginx/nginx.conf

Expose port 80
EXPOSE 80

Start Nginx
CMD ["nginx", "-g", "daemon off;"]
