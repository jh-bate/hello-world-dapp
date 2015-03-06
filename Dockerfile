FROM debian:wheezy
MAINTAINER Eris Industries <support@ErisIndustries.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -qy && apt-get install -qy \
  curl \
  git \
  ruby

RUN gem install foreman

RUN git clone https://github.com/cloudfoundry/nodejs-buildpack.git \
  /opt/buildpack

WORKDIR /opt/buildpack
RUN git checkout v1.1.1
RUN git submodule update --init --recursive

RUN useradd --system --create-home node
WORKDIR /home/node
COPY . .

RUN /opt/buildpack/bin/detect .
RUN /opt/buildpack/bin/compile .

RUN chown --recursive node: .
USER node
ENV PATH /home/node/vendor/node/bin:$PATH
CMD ["/usr/local/bin/foreman", "start"]
