#!/bin/bash

cd /app
cp /tmp/environments/.env ./src/.env
npx prisma generated
apk update
npm run dev