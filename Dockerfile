FROM alpine:latest
MAINTAINER David Buksbaum <david@buksbaum.us>

ENV HUGO_VERSION 0.17
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-64bit
ENV HUGO_EXE hugo_${HUGO_VERSION}_linux_amd64

# Install pygments (for syntax highlighting)
RUN apk update && apk add py-pygments && apk add git && apk add bash && apk add git && apk add glib && rm -rf /var/cache/apk/*

# make hugo directory structure
RUN mkdir /hugo

# Download and Install hugo
ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /hugo/
RUN tar xzf /hugo/${HUGO_BINARY}.tar.gz -C /hugo/ \
	&& rm /hugo/${HUGO_BINARY}.tar.gz

RUN mv /hugo/${HUGO_EXE}/${HUGO_EXE} /hugo/hugo
RUN rm -r /hugo/${HUGO_EXE}
 
#RUN git clone --recursive https://github.com/metral/hugoThemes.git /hugo/src/themes
RUN git clone --depth 1 --recursive https://github.com/dbuksbaum/hugoThemes.git /hugo/src/themes

VOLUME ["/hugo/src", "/hugo/dest"]

EXPOSE 1313

WORKDIR /hugo

#ENTRYPOINT ["/hugo/hugo"]
CMD ["/hugo/hugo", "--source=/hugo/src", "--destination=/hugo/dest"]

