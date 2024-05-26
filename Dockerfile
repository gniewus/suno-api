# syntax=docker/dockerfile:1

FROM node:lts AS builder
WORKDIR /src
COPY package*.json ./
RUN npm update
RUN npm install --ignore-script 
COPY . .
RUN npm run build

FROM builder
WORKDIR /app
COPY package*.json ./
COPY .env ./
RUN npm install --only=production  --ignore-script 
COPY --from=builder /src/.next ./.next
EXPOSE 3000
CMD ["npm", "run", "start"]
