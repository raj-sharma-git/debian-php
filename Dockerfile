FROM php:8.2.10-apache
COPY index.php /var/www/html/

WORKDIR /app/

COPY . .

COPY sshd_config /etc/ssh/

# Start and enable SSH
RUN apt-get update \
    && apt-get install -y --no-install-recommends dialog \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd \
    && chmod u+x /app/init_container.sh

EXPOSE 80 2222

ENTRYPOINT [ "/app/init_container.sh" ] 