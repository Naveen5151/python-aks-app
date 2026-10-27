FROM python:3.13-alpine

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apk upgrade --no-cache

COPY requirements.txt .
RUN python -m pip install --no-cache-dir --upgrade pip \
 && python -m pip install --no-cache-dir -r requirements.txt

RUN addgroup -S user && adduser -S user -G user

COPY --chown=user:user . .

USER user
EXPOSE 5000
CMD ["python", "app.py"]