#!/bin/bash

cd /app
cp /tmp/environments/.env ./src/.env
npx prisma generated
npm run dev