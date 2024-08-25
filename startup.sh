#!/bin/bash

# Install the dependencies
echo "Installing dependencies..."
python -m pip install --no-cache-dir -r requirements.txt || { echo "Failed to install dependencies"; exit 1; }

# Fetch the PORT environment variable from Azure App Service or default to 8000
PORT=${PORT:-8000}

# Start the application
echo "Starting the application on port $PORT..."
python app.py --port=$PORT || { echo "Failed to start the application"; exit 1; }
