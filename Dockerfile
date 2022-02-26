# multistep process (step is "stage" in docker terminology)

# 1st step: build
FROM node:16-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .

# next build command will put everything to the /app/build (configured by create-react-app)
RUN npm run build

# 2nd step: serve result from 1st step
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# nginx will auto start, so no RUN command needed



# USAGE
# to build (with custom tag name): docker build -t arty/cra-nginx .
# to start: docker run -p 8080:80 arty/cra-nginx