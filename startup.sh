#!/bin/bash

# Fail on any error
set -e

# Define the virtual environment directory
VENV_DIR="venv"

# Create and activate the virtual environment
if [ ! -d "$VENV_DIR" ]; then
    python -m venv $VENV_DIR
fi
source $VENV_DIR/bin/activate

# Install the dependencies
echo "Installing dependencies..."
pip install --no-cache-dir -r requirements.txt || { echo "Failed to install dependencies"; exit 1; }

# Fetch the PORT environment variable from Azure App Service or default to 8000
PORT=${PORT:-8000}

# Start the application
echo "Starting the application on port $PORT..."
exec gunicorn --bind 0.0.0.0:$PORT app:app || { echo "Failed to start the application"; exit 1; }
