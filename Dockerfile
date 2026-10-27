FROM python:3.13-alpine

WORKDIR /app

COPY requirements.txt .

# Update Alpine packages
RUN apk update && \
    apk upgrade --no-cache

# Upgrade Python packaging tools
RUN python -m pip install --no-cache-dir --upgrade pip setuptools

# Install application dependencies directly into final image
RUN python -m pip install --no-cache-dir --upgrade -r requirements.txt

COPY . .

RUN addgroup -S user && \
    adduser -S user -G user && \
    chown -R user:user /app

USER user

EXPOSE 5000

CMD ["python", "app.py"]