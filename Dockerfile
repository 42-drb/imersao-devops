# 1. Base Image: Use a slim and stable Python image that aligns with your project's needs (Python 3.10+).
# The -slim variant is a good balance between size and having necessary system libraries.
FROM python:3.13.5-alpine3.22

# 2. Set Environment Variables for best practices in containers
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Set the working directory inside the container
WORKDIR /app

# 4. Copy and Install Dependencies
# Copying requirements.txt first allows Docker to cache this layer.
# The layer will only be rebuilt if requirements.txt changes.
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of the application code into the working directory
COPY . .

# 6. Expose the port the application runs on
EXPOSE 8000

# 7. Define the command to run the application
# Use --host 0.0.0.0 to make the app accessible from outside the container.
# The --reload flag is for development; it's removed for a production-like image.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
