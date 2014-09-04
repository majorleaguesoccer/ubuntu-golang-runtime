FROM ubuntu:14.04

MAINTAINER Bryce Kahle, bryce.kahle@mlssoccer.com

RUN apt-get update && apt-get install -y -q --no-install-recommends \
		curl \
		build-essential \
		ca-certificates \
		git \
		mercurial \
		bzr

RUN mkdir /goroot && curl https://storage.googleapis.com/golang/go1.3.1.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
RUN mkdir /gopath

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

ADD go-build /bin/go-build
ADD go-run /bin/go-run

ONBUILD ADD . /gopath/src/app/
ONBUILD RUN /bin/go-build

CMD []
ENTRYPOINT ["/bin/go-run"]
