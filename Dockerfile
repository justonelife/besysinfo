# Use a Node.js base image
FROM node:20 AS base
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the NestJS application
FROM base AS builder
RUN npm run build

# Create the final image with only necessary files
FROM node:20-alpine AS final
WORKDIR /app

# Copy package files again and install only production dependencies
COPY package.json package-lock.json ./
RUN npm install --omit=dev

# Copy built files from builder stage
COPY --from=builder /app/dist ./dist

# Expose the application port
EXPOSE 3000

# Run the application
CMD ["node", "dist/main"]

