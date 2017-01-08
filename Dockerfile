FROM ubuntu

RUN apt-get update
RUN apt-get install -y wget curl git make gcc libncurses5-dev sudo zip

RUN wget -O frotz_src.tgz https://sourceforge.net/projects/frotz/files/latest/download
RUN tar xvzf frotz_src.tgz
RUN rm frotz_src.tgz
RUN cd frotz* && make && mv frotz /usr/local/bin

RUN useradd frotz --create-home --shell /bin/bash
RUN echo 'frotz:frotz' | chpasswd
RUN sudo adduser frotz sudo
USER frotz
WORKDIR /home/frotz
ADD zfiles .

CMD bash
