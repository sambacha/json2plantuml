VERSION=0.1.0

FROM alpine:3.11

ARG VERSION
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN wget --quiet https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub -P /etc/apk/keys/ && \
    echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories && \
    apk --no-cache add zulu11-jre-headless

ENV JAVA_HOME=/usr/lib/jvm/zulu11-ca

COPY bin /home/bin
COPY entry-point.sh /home/entry-point.sh

RUN echo export JAVA_HOME=/usr/lib/jvm/zulu-11-amd64 && echo "$JAVA_HOME"

RUN mkdir -p -q /opt/plantuml \
    touch /opt/plantuml/.gitkeep \
    cp /bin/plantuml.jar /opt/plantuml \
    echo '#!/usr/bin/env sh' > plantuml.sh \
    echo 'exec java -jar /opt/plantuml/plantuml.jar "$@"' >> plantuml.sh \
    sudo install -m 755 plantuml.sh /usr/local/bin/plantuml \
    plantuml -version

CMD ["entry-point.sh"]

ARG BUILD_DATE
ARG VCS_REF
