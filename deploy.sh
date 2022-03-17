#!/bin/bash

cd /app
cp /tmp/environments/.env ./src/.env
npx prisma generate
apt install curl -y
npm run dev