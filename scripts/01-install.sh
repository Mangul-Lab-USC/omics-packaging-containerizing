#! /bin/bash -e

## Singularity installation ------------------------------------------
## Install required libraries
sudo yum update -y
sudo yum groupinstall -y 'Development Tools'
sudo yum install -y \
    openssl-devel \
    libuuid-devel \
    libseccomp-devel \
    wget \
    squashfs-tools

## Install GO on default location
export VERSION=1.11 OS=linux ARCH=amd64

wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz 
sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz
rm go$VERSION.$OS-$ARCH.tar.gz

## Add GO variable to bashrc
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc
echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc
source ~/.bashrc

## Install GO packages
go get -u github.com/golang/dep/cmd/dep

## Download and compile Singularity
export VERSION=v3.0.3 # or another tag or branch if you like

mkdir -p $GOPATH/src/github.com/sylabs
cd $GOPATH/src/github.com/sylabs
wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz
tar -xzf singularity-${VERSION}.tar.gz
cd ./singularity

./mconfig && make -C ./builddir && sudo make -C ./builddir install

## Miniconda installation --------------------------------------------
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b

echo 'source ${HOME}/miniconda3/etc/profile.d/conda.sh' >> ~/.bashrc
source ~/.bashrc

## Clean up environment ----------------------------------------------
sudo yum clean all
