#!/bin/bash

cd /app
cp /tmp/environments/.env ./.env
npx prisma generate
cat ./env
npm run dev