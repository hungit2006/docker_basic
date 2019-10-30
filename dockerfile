FROM ubuntu:16.04

# Attached information
LABEL	author.name="Hungit" \
	author.email="hungit2006@gmail.com"

# Configure the main working directory. This's the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.

ENV	APP_PATH /bin
WORKDIR	&APP_PATH

# Set the timezone.

ENV 	TZ=Asia/Ho_Chi_Minh
RUN	set -x \
	&& ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
	&& echo $TZ > /etc/timezone

RUN	set -x \
	&& apt-get update \
	&& apt-get install -y nginx nano vim

RUN	set -x \
	&& echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
	&& echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
	&& apt-get install -y mysql-server

COPY start.sh /bin

RUN	set -x \
	&& chmod a+x /bin/*

ENTRYPOINT ["/bin/start.sh"]

EXPOSE 80
