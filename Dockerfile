FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn
COPY . .
RUN mkdir -p /app/data/Media/PGNs && \
    python manage.py collectstatic --noinput
EXPOSE 8080
CMD ["gunicorn", "OpenSite.wsgi:application", "--bind", "0.0.0.0:8080", "--workers", "2"]
