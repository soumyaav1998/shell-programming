#!/bin/bash
cat > Dockerfile <<EOF
FROM python:3.12-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
CMD ["python", "app.py"]
EOF

# This will create a dockerifle and write those lines in it
#  EOF can be any text it can be like 
cat <<something
this
is an example
for heredoc
something