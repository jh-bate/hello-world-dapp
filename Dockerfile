FROM debian:stable

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -qy && apt-get install -qy \
  curl \
  ruby

RUN gem install foreman

RUN curl --location https://github.com/heroku/heroku-buildpack-nodejs/archive/master.tar.gz \
 | tar --extract --gzip --directory=/opt

RUN useradd --system --create-home node
WORKDIR /home/node
COPY . .

RUN /opt/heroku-buildpack-nodejs-master/bin/detect .
RUN /opt/heroku-buildpack-nodejs-master/bin/compile .

RUN chown --recursive node: .
USER node
ENV PATH /home/node/.heroku/node/bin:$PATH
CMD ["/usr/local/bin/foreman", "start"]
