from node:20-alpine
workdir /app
copy . .
run npm i
run npm run build
cmd ["node", "./dist/main"]
