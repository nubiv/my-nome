#!/bin/bash

mkdir -p /opt/certbot
cd /opt/certbot
uv venv /opt/certbot
uv pip install --upgrade pip
uv pip install certbot certbot-dns-cloudflare
ln -sf /opt/certbot/bin/certbot /usr/bin/certbot