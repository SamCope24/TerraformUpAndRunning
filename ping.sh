#!/bin/bash
ALB=http://webservers-stage-1422304229.us-east-2.elb.amazonaws.com/

while true; 
    do curl $ALB
    sleep 1; 
done
# simple script for curling the ALB