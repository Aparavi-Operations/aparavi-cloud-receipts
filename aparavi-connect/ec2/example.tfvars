# Name of AWS CLI profile you want to use. This can be omitted if the [default]
# profile points to the account you want to deploy in.
aws_profile = "my-profile"

# Amazon EC2 Key pair name.
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html?icmpid=docs_ec2_console
# You must create the key pair beforehand. You will need the key in order to
# ssh into EC2 instances.
KEY_NAME = "aparavi"
# Network CIDR to whitelist SSH into instances from.
MANAGEMENT_NETWORK = "0.0.0.0/0"

# Main name of resources
DEPLOYMENT = "aparavi"

# Aparavi platform host in HOSTNAME[:PORT] format
PLATFORM = "preview.aparavi.com"
# Aparavi platform node ID to connect aggregator to
PARENT_ID = "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
