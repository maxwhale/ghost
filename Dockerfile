FROM ubuntu:14.04
MAINTAINER Max

RUN apt-get update && apt-get install -y python g++ make software-properties-common --force-yes curl unzip htop screen nodejs npm
RUN add-apt-repository ppa:chris-lea/node.js
RUN curl -L https://ghost.org/zip/ghost-latest.zip > /tmp/ghost.zip
RUN useradd ghost
RUN mkdir -p /opt/ghost
WORKDIR /opt/ghost
RUN unzip /tmp/ghost.zip
RUN npm install --production

# Volumes
RUN mkdir /data
VOLUME ["/data"]

ADD run /usr/local/bin/run
ADD config.js /opt/ghost/config.js
RUN chown -R ghost:ghost /opt/ghost

ENV NODE_ENV production
ENV GHOST_URL http://my-ghost-blog.com
EXPOSE 2368
CMD ["/usr/local/bin/run"]

