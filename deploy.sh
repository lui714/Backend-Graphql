#!/bin/bash

cd /app
cp /tmp/environments/.env ./.env
npx prisma generate
cat /tmp/environments/.env
cat /app/.env
npm run dev