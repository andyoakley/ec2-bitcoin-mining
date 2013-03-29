ec2-bitcoin-mining
==================

Setup for Bitcoin mining on EC2 cg1.4xlarge instances. This makes no economic sense.

What this does: Creates an autoscaling rule to start new EC2 instances at spot pricing which will mine for Bitcoins. Total rate per instance is about 170 Mhash/s with lowest spot prices being around $0.37/hr. 

This implementation is a bit hacky but it's not worth cleaning up.

Instructions
------------
The scripts require some edits for your setup (notification ARN, pool passwords, etc.)

1. Start a cg1.4xlarge with ami-4583572c. Connect to this instance to set it up.
1. Edit and run setup-ami.sh on your instance.
1. Reboot the instance, make sure the miners come up. There should be three detached screens (see them with screen -r), two running miners on the GPUs, one running on the CPU.
1. If all looks good, create your own AMI from this.
1. Create your autoscaling rules by editing and running setup-autoscale.sh on a machine with the AWS Auto Scaling Command Line tools installed.
1. Wait. The autoscaling will automatically start instances when the spot pricing is below your bid price and they'll start

I wish the last step was profit. nVidia Teslas are not well suited to mining and so the return is well below the cost.

