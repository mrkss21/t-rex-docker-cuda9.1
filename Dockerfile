FROM nvidia/cuda:9.2-devel
ENTRYPOINT ["/home/miner/run-miner.sh"]

RUN groupadd -g 2000 miner && \
    useradd -u 2000 -g miner -m -s /bin/bash miner && \
    echo 'miner:miner' | chpasswd
RUN apt-get -y update
RUN apt-get -y install git automake libssl-dev libcurl4-openssl-dev wget

COPY run-miner.sh /home/miner/
RUN chmod +x /home/miner/run-miner.sh
RUN chown miner:miner /home/miner/run-miner.sh

RUN mkdir /home/miner/t-rex/
COPY t-rex /home/miner/t-rex
RUN chmod 755 /home/miner/t-rex
RUN chown miner:miner /home/miner/t-rex

USER miner

#RUN mkdir /home/miner/t-rex \
#    && wget "https://github.com/mrkss21/t-rex-docker-cuda9.2/raw/master/t-rex" -O /home/miner/t-rex/miner \
#    && chmod 0755 /home/miner && chmod 0755 /home/miner/t-rex && chmod 755 /home/miner/t-rex/miner 


ENV ALGO c11
ENV MINING_POOL stratum+tcp://vps205351.vps.ovh.ca:4553
ENV USER ""
ENV PASSWORD ""
ADD run-miner.sh /
CMD [‘/home/miner/run-miner.sh’]
