FROM python:3.11-slim

WORKDIR /app

# Install ffmpeg and libsndfile for audio support
RUN apt-get update && \
    apt-get install -y ffmpeg libsndfile1 --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade pip && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

COPY . /app

EXPOSE 8000

# Default command: try common entrypoints. Adjust if your project uses a different start command.
CMD ["python3", "backend/main.py"]
