##
# Wiresafe deployment of sydent - so we can customize the invite / email workflow
# todo:
# - copy changes from res/ to get customized email messages
# - configure email (smtp) service
## 
FROM python:2.7-jessie

ARG username="matrix-sydent"
ARG password="${username}"

# install requirements per https://github.com/matrix-org/synapse#id11
RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get clean && \
	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y \
		build-essential \
		python2.7-dev \
		libffi-dev \
		python-pip \
		python-setuptools \
		sqlite3 \
		libssl-dev \
		python-virtualenv \
		libjpeg-dev \
		libxslt1-dev && \
	pip install --upgrade pip && \
	pip freeze > requirements.txt && \
	pip install --upgrade -r requirements.txt && \
	rm requirements.txt

# install sydent and run setup.py
RUN pip install --upgrade https://github.com/matrix-org/sydent/tarball/master

# install matrix root user
RUN useradd -rm -g root matrix-sydent

# when running as user I'm getting db access errors - running as root for now
# USER "${username}"
VOLUME ["/home/${username}/config"]
WORKDIR "/home/${username}/config"

EXPOSE 8090

# I'm not sure if the --server-name can be set this way
CMD python -B -m sydent.sydent --server-name=id.wiresafe.com