FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get -y install libpython3.9
RUN apt-get -y install python3-pip

# install the notebook package
RUN pip3 install --no-cache --upgrade pip && \
    pip3 install --no-cache notebook jupyterlab

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

RUN wget https://github.com/ilaspltd/ILASP-releases/releases/download/v4.3.1/ILASP-4.3.1-ubuntu.tar.gz
RUN tar -xzf ILASP-4.3.1-ubuntu.tar.gz
