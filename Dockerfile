# Base docker image
FROM openjdk:8-alpine
LABEL maintainer="Morgan Kobeissi <holla@mcmoe.com>"

ENV LEIN_ROOT true

RUN wget -q -O /usr/bin/lein \
    https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
    && chmod +x /usr/bin/lein

RUN apk update

RUN apk add git bash

RUN mkdir /app
WORKDIR /app

RUN git clone https://github.com/adamtornhill/code-maat.git
WORKDIR code-maat

RUN /usr/bin/lein uberjar

WORKDIR target
# Rename the standalone jar to be version independant for the future
RUN find . -name '*standalone*' -exec bash -c 'mv $0 codemaat-standalone.jar' {} \;

# ENTRYPOINT ["java","-jar","code-maat-0.9.2-SNAPSHOT-standalone.jar"]
ENTRYPOINT ["java","-jar","codemaat-standalone.jar"]
# ENTRYPOINT ["/usr/bin/lein", "run"]
CMD ["-h"]
