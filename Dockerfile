FROM alpine:3.12 as buildbase

# install all the stuff we need to build
RUN apk --no-cache --update add wget curl git make gcc musl-dev ncurses-dev zip; \
  rm -rf /var/cache/apk/*;

ARG GIT_CHECKOUT=2.52
WORKDIR /tmp
RUN git clone https://gitlab.com/DavidGriffith/frotz; cd frotz; git checkout ${GIT_CHECKOUT}
RUN cd frotz && make nosound && mv frotz /usr/local/bin

# clean up
#RUN rm -rf /tmp/frotz; \
#    apk del wget curl git make gcc musl-dev zip

FROM alpine:latest
#COPY --from=0 /usr/lib /usr/lib
#COPY --from=0 /usr/include /usr/include
COPY --from=0 /usr/local/bin /usr/local/bin
#COPY --from=0 /usr /usr

RUN apk --no-cache --update add musl ncurses; \
  rm -rf /var/cache/apk/*;

# user setup
ENV USER=frotz
ENV UID=12345
ENV GID=23456
RUN addgroup --gid $GID $USER
RUN adduser \
    --disabled-password \
    --gecos "" \
    --ingroup "$USER" \
    --uid "$UID" \
    "$USER"

# switch to the new user
USER frotz
WORKDIR /home/frotz

# add zfiles from local filesystem so they're easily accessible
ADD zfiles .

CMD ash
