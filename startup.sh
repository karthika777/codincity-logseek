python -m pip install -r requirements.txt || { echo "Failed to install dependencies"; exit 1; }
python app.py || { echo "Failed to start the application"; exit 1; }

