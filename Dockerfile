# Use the official MariaDB image as the base image
FROM mariadb:latest

# Set environment variables for MariaDB
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=routes_db
ENV MYSQL_USER=foo
ENV MYSQL_PASSWORD=foo

# Expose the default MariaDB port
EXPOSE 3306

# Install Python and necessary packages
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install mysql-connector-python

# Copy the Python scripts into the container
COPY db_to_csv.py /usr/src/app/db_to_csv.py
COPY csv_to_db.py /usr/src/app/csv_to_db.py
COPY create_db.py /usr/src/app/create_db.py

# Set the working directory
WORKDIR /usr/src/app

# Run the create_db.py script to set up the database and table
CMD ["python3", "create_db.py"]
