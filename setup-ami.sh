#!/bin/bash

# Start from StarCluster HVM Ubuntu 11.10 
# ami-4583572c

#
# Install prereq
#
sudo apt-get install libcurl4-dev

#
# Setup cgminer
#
git clone https://github.com/ckolivas/cgminer.git
./autogen.sh --enable-cpumining
make

#
# Setup poclbm
#
git clone https://github.com/m0mchil/poclbm.git

#
# Setup launch script - update USER/PASS/POOL settings here
#
cat >~/mine.sh <<EOF
#!/bin/bash
USER=
PASS=
POOL=stratum.bitcoin.cz:3333

cd ~/cgminer
screen -d -m ./cgminer -o $POOL -u $USER -p $PASS -a auto

cd ~/poclbm
screen -d -m sudo python poclbm.py -v -w 256 --device 0 stratum://$USER:$PASS@$POOL
screen -d -m sudo python poclbm.py -v -w 256 --device 1 stratum://$USER:$PASS@$POOL
EOF

#
# Launch on boot
#
sudo echo "sudo -u ubuntu /home/ubuntu/mine.sh" > /etc/rc.local