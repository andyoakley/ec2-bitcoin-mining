#!/bin/bash

# Requires AWS AutoScaling tools http://aws.amazon.com/developertools/2535

# Settings
AMI=
PRICE=0.4
NOTIFYTOPIC=
KEYPAIR=
MAXINSTANCES=10

#
# Define what a worker does
#
as-create-launch-config spotminer --image-id $AMI --instance-type cg1.4xlarge --spot-price $PRICE --monitoring-disabled --key $KEYPAIR

#
# Set up scaling group to maintain spot bids
#
as-create-auto-scaling-group minerasg --launch-configuration spotminer --availability-zones "us-east-1a,us-east-1b,us-east-1d" --max-size $MAXINSTANCES --min-size 1 --desired-capacity $MAXINSTANCES

#
# Optional: Send notification on instance creation/termination
#
as-put-notification-configuration minerasg --topic-arn $NOTIFYTOPIC --notification-types autoscaling:EC2_INSTANCE_LAUNCH, autoscaling:EC2_INSTANCE_TERMINATE
