FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    postgresql-client \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Install python-dotenv
RUN pip install python-dotenv

# Load environment variables from .env file
RUN python -c "from dotenv import load_dotenv; load_dotenv(override=True)"

# Expose the port the app will run on
ARG PORT=8000
ENV PORT=${PORT}
EXPOSE ${PORT}

# Copy the rest of the application files
COPY .. /app

# Command to start the Django development server
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:${PORT}"]
