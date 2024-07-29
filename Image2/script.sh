#!/bin/bash
/usr/local/bin/aws configure set aws_access_key_id X
/usr/local/bin/aws configure set aws_secret_access_key X

aws s3 cp /root/output/timestamp s3://test-terraform
