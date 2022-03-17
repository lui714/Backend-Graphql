#!/bin/bash

cd /app
cp /tmp/environments/.env ./src/.env
npx prisma generated
apt update
apt install -y mongodb-org-shell
npm run dev