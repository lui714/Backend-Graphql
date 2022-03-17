#!/bin/bash

cd /app
cp /tmp/environments/.env ./src/.env
npx prisma generate
npm run dev