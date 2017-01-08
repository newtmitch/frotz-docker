FROM ubuntu

RUN apt-get update
RUN apt-get install -y wget curl git make gcc libncurses5-dev sudo



RUN wget -O frotz_src.tgz https://sourceforge.net/projects/frotz/files/latest/download
RUN tar xvzf frotz_src.tgz
RUN rm frotz_src.tgz
RUN cd frotz* && make && mv frotz ..
RUN mv frotz /usr/local/bin

RUN useradd frotz -m -p frotz
USER frotz
WORKDIR /home/frotz
ADD zfiles .

CMD bash
