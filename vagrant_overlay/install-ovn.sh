apt-get update
apt-get install -y build-essential fakeroot debhelper \
                    autoconf automake bzip2 libssl-dev \
                    openssl graphviz python-all procps \
                    python-qt4 python-zopeinterface \
                    python-twisted-conch libtool git dh-autoreconf




git clone https://github.com/openvswitch/ovs.git
cd ovs
./boot.sh
./configure --prefix=/usr --localstatedir=/var  --sysconfdir=/etc --enable-ssl --with-linux=/lib/modules/`uname -r`/build
make -j3 
make install
cp debian/openvswitch-switch.init /etc/init.d/openvswitch-switch
rmmod openvswitch
sudo modprobe libcrc32c
insmod ./datapath/linux/openvswitch.ko
insmod ./datapath/linux/vport-geneve.ko
cp -rf ./python/ovs /usr/local/lib/python2.7/dist-packages/.
/etc/init.d/openvswitch-switch start


git clone https://github.com/shettyg/ovn-docker.git
cd ovn-docker
cp * /usr/local/bin/
cd vagrant_overlay
chmod 755 test1.sh test2.sh test3_node1.sh test3_node2.sh test3_cleanup_node1.sh test3_cleanup_node2.sh clean_all.sh
cp *.sh /usr/local/bin
sh /usr/local/bin/clean_all.sh

mkdir -p /etc/docker/plugins

# Pulling in the world to make it run...
apt-get install -y python-dev python-setuptools
easy_install -U pip
pip install oslo.utils
# Install via PIP to get the latest version (Ubunutu is way too old)
pip install python-neutronclient
pip install flask

