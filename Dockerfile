FROM ubuntu:20.04

# Install required packages
RUN apt-get update && apt-get install -y cowsay fortune netcat

# Set working directory
WORKDIR /app

# Copy script into container
COPY wisecow.sh /app/wisecow.sh

# Expose Wisecow port
EXPOSE 4499

# Run the script
CMD ["bash", "wisecow.sh"]

