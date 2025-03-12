# base images:
# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
# https://github.com/jupyter/docker-stacks

FROM quay.io/jupyter/minimal-notebook
#FROM quay.io/jupyter/datascience-notebook

ENV NODE_VERSION 18.20.7
ENV GO_VERSION=1.21.5
ENV GOROOT="/usr/local/go"
ENV GOPATH="$HOME/go"

# Use bash for the shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Create a script file sourced by both interactive and non-interactive bash shells
ENV BASH_ENV=$HOME/.bash_env
RUN touch "${BASH_ENV}"
RUN echo '. "${BASH_ENV}"' >> ~/.bashrc

# Download and install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | PROFILE="${BASH_ENV}" bash
RUN echo node > .nvmrc
RUN nvm install

# Install IJavascript kernel
RUN npm install -g ijavascript && \
    ijsinstall 
#--install=global

# Download and install Go и ядра Gophernotes
RUN mkdir -p $GOPATH

USER root
RUN mkdir -p $GOROOT && \
    wget -O go.tgz "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" && \
    tar -C /usr/local -xzf go.tgz && \
    rm go.tgz
USER jovyan
ENV PATH=$PATH:$GOROOT/bin

# Download and install Gophernotes kernel
RUN  mkdir -p "$(go env GOPATH)"/src/github.com/gopherdata && \
  cd "$(go env GOPATH)"/src/github.com/gopherdata && \
  git clone https://github.com/gopherdata/gophernotes && \
  cd gophernotes && \
  git checkout -f v0.7.5 && \
  go install && \
  mkdir -p ~/.local/share/jupyter/kernels/gophernotes && \
  cp kernel/* ~/.local/share/jupyter/kernels/gophernotes && \
  cd ~/.local/share/jupyter/kernels/gophernotes && \
  chmod +w ./kernel.json && \
  # in case copied kernel.json has no write permission
  sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json


# install python lib
# RUN pip install --no-cache-dir matplotlib scikit-learn

# install material darcula theme https://github.com/adhadse/theme-material-darcula \
# RUN conda install -c conda-forge theme-material-darcula