# Dockerfile for FastAPI Backend on Render

# Use an official, standard Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file first to leverage Docker cache
COPY requirements.txt .

# Install the Python dependencies
# The --no-cache-dir option is a good practice for keeping the image size down
RUN pip install --no-cache-dir -r requirements.txt

# Copy your entire project code (including the 'app', 'api', etc. directories) into the container
COPY . .

# Render provides a PORT environment variable that the app should listen on.
# We expose this port for documentation. Render maps it automatically.
EXPOSE 10000

# The command to run your Uvicorn server.
# This uses the shell form so that the $PORT environment variable provided by Render is correctly used.
CMD uvicorn app.main:app --host 0.0.0.0 --port $PORT