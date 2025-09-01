#!/usr/bin/env bash
set -euo pipefail

# Minimal Ubuntu setup for macos-local-voice-agents (ubuntu-support branch)
# Installs system dependencies, creates a python venv, installs Python deps,
# and prints next steps.

echo "Updating apt and installing packages..."
apt update
apt install -y python3 python3-venv python3-pip ffmpeg git build-essential libsndfile1 curl 

# Optional: install docker if user prefers docker deployment
if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found. If you want to use Docker, install it separately or run the installer below."
  echo "To install Docker now, uncomment the lines in this script and run again."
fi

# Project setup
PROJECT_DIR="$(pwd)"

# Create .env from example if present
if [ -f .env.example ] && [ ! -f .env ]; then
  cp .env.example .env
  echo "Created .env from .env.example. Edit .env to add any API keys you need."
fi

# Create Python venv and install requirements if requirements.txt exists
if [ -f requirements.txt ]; then
  echo "Creating Python virtualenv..."
  python3 -m venv venv
  # shellcheck disable=SC1091
  . venv/bin/activate
  pip install --upgrade pip
  pip install -r requirements.txt
  echo "Python deps installed in venv/"
else
  echo "No requirements.txt found. Skipping Python package installation."
fi

# Helpful reminders
cat <<'EOF'
Setup script finished.
Next steps:
- Edit .env and add API keys (OPENAI_API_KEY, etc) as needed.
- If using the Python venv: source venv/bin/activate and run your app (e.g. python backend/main.py or uvicorn backend.main:app --host 0.0.0.0 --port 8000)
- Or start with Docker: docker-compose up --build
EOF

exit 0
