#!/bin/bash
set -e

# Define the virtual environment directory
VENV_DIR="venv"

# Create and activate the virtual environment
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv $VENV_DIR
fi
source $VENV_DIR/bin/activate


# Install the dependencies
echo "Installing dependencies..."
pip install --no-cache-dir -r requirements.txt || { echo "Failed to install dependencies"; exit 1; }

pip install guardrails-ai

pip install better_profanity

pip install --upgrade llama-index

pip install gradio azure-storage-blob llama-index guardrails pandas
 
pip install --upgrade pip setuptools wheel

pip install guardrails==0.0.5

# Fetch the PORT environment variable from Azure App Service or default to 8000
PORT=${PORT:-8000}

# Set Gunicorn concurrency and timeout settings
WORKERS=${WEB_CONCURRENCY:-2}
TIMEOUT=${GUNICORN_TIMEOUT:-120}

# Start the application with Gunicorn and optimized settings
echo "Starting the application on port $PORT with $WORKERS workers and a timeout of $TIMEOUT seconds..."
exec gunicorn --workers $WORKERS --timeout $TIMEOUT --bind 0.0.0.0:$PORT app:app || { echo "Failed to start the application"; exit 1; }
