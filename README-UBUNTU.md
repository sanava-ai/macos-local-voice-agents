# Ubuntu setup (ubuntu-support branch)

This file describes two supported ways to run the project on an Ubuntu SSH server: native (Python venv) and Docker.

## Prerequisites
- Ubuntu 20.04 or later
- git
- sudo access

## 1) Native (python venv)

1. Clone the repo and switch branch:

```bash
git clone https://github.com/sanava-ai/macos-local-voice-agents.git
cd macos-local-voice-agents
git checkout ubuntu-support
```

2. Run the setup script (it will create a .env from .env.example if present and create a venv if requirements.txt exists):

```bash
chmod +x setup-ubuntu.sh
sudo ./setup-ubuntu.sh
```

3. Edit `.env` to provide any API keys required by the features you want to use (e.g. OPENAI_API_KEY).

4. Activate the venv and run the app (commands depend on your backend):

```bash
source venv/bin/activate
# Example for a simple Python app
python backend/main.py
# Example for FastAPI
# uvicorn backend.main:app --host 0.0.0.0 --port 8000
```

## 2) Docker (recommended for reproducibility)

1. Make sure Docker and docker-compose are installed on the server.
2. From the repo root:

```bash
docker-compose up --build -d
```

3. View logs and status:

```bash
docker-compose logs -f
docker-compose ps
```

## Environment variables
Edit `.env` and provide any API keys you want to enable. Typical variables:

- OPENAI_API_KEY - for language model features
- TTS_API_KEY - for external TTS providers
- SPEECH_API_KEY - for STT providers

If you don't provide them, features that rely on those services will be disabled or raise errors.

## Troubleshooting
- If the app doesn't start, check logs (system or docker-compose logs).
- Missing Python packages: ensure `requirements.txt` lists your deps.
