FROM node:18-alpine

RUN npm install -g pnpm

WORKDIR /app

# Copy root package.json and lockfile
COPY package.json ./

# Copy core package.json
COPY packages/core/package.json ./packages/core/package.json

# Copy tailwind-config package.json
COPY packages/tailwind-config/package.json ./packages/tailwind-config/package.json

# Copy tsconfig package.json
COPY packages/tsconfig/package.json ./packages/tsconfig/package.json

# Copy web package.json
COPY apps/web/package.json ./apps/web/package.json

# Copy app source
COPY . .

RUN pnpm i && \
    pnpm build

EXPOSE 3000

RUN cd apps/web && pnpm build

CMD ["pnpm", "-C", "apps/web", "run", "start"]
