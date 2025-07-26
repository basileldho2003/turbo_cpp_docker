FROM alpine:latest

# Set build-time variables, overridable via --build-arg
#ARG USER_ID=1000
#ARG GROUP_ID=1000

RUN apk update && apk upgrade --no-cache && apk add --no-cache \
    mesa-utils \
    sdl2 \
    sdl2_image \
    sdl2_ttf \
    sdl2_mixer \
    dosbox-staging && \
    rm -rf /var/cache/apk/*

#RUN addgroup -g $GROUP_ID tcpp && \
#    adduser -D -u $USER_ID -G tcpp tcpp

WORKDIR /opt

COPY Turbo_CPP/ /opt/

#RUN chown -R tcpp:tcpp /opt/TURBOC3

#USER tcpp

ENV DISPLAY=:0
ENV XDG_RUNTIME_DIR=/run/user/1000
ENV PULSE_SERVER=unix:/run/user/1000/pulse/native

CMD ["dosbox", "--noconsole", "-conf", "/opt/dosbox-staging-tc.conf"]
