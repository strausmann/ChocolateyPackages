FROM gitpod/workspace-full

RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.1.0/powershell_7.1.0-1.ubuntu.20.04_amd64.deb && \
  sudo add-apt-repository universe && \
  sudo dpkg --force-all -i powershell_7.1.0-1.ubuntu.20.04_amd64.deb && \
  rm powershell_7.1.0-1.ubuntu.20.04_amd64.deb

RUN wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb && \
  sudo dpkg --force-all -i libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb && \
  rm libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb

USER root
