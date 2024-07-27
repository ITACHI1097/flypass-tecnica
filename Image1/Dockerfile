# Use the official nginx base image
FROM ubuntu:latest

# Install necessary software
RUN apt-get update && \
    apt-get -y install cron

# Add crontab file
COPY crontab /etc/cron.d/crontab

# Add script
COPY script.sh /root/script.sh
RUN chmod +x /root/script.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontab

RUN crontab /etc/cron.d/crontab 

# Create the log file to be able to run tailcrontab /etc/cron.d/crontab 

# RUN crontab -l | { cat; echo "0 0 0 0 0 some entry"; } | crontab -
RUN touch /var/log/cron.log

# Start the cron service
CMD cron && tail -f /var/log/cron.log