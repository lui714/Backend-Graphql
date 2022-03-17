#!/bin/bash

cd /app
cp /tmp/environments/.env ./src/.env
npx prisma generated
apk update
apk install -y mongodb-org-tools
npm run dev