FROM python:3.13-alpine as base

WORKDIR /app

COPY requirements.txt .

RUN apk update && apk upgrade --no-cache

#RUN python -m pip install --no-cache-dir --upgrade pip setuptools

RUN python -m pip install --upgrade --no-cache-dir --prefix=/install -r requirements.txt


FROM python:3.13-alpine 

WORKDIR /app

RUN python -m pip install  --no-cache-dir --upgrade pip setuptools msgpack utillib3

COPY --from=base /install /usr/local

COPY . .

RUN addgroup -S user && adduser -S user -G user

RUN chown -R user:user /app

USER user

EXPOSE 5000

CMD ["python", "app.py"]