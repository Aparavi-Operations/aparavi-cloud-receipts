# GCP project ID, region and zone you want to deploy resources in.
project="my-gcp-project-id"
region = "us-west1"
zone = "us-west1-b"

# Main name of most of resources, such as VPC, EKS, RDS...
name = "aparavi"

# Aparavi platform host in HOSTNAME[:PORT] format
platform_host = "preview.aparavi.com"
# Aparavi platform node ID to connect aggregator to
platform_node_id = "11111111-aaaa-1111-aaaa-111111111111"
# Aggregator node name. This will be the name shown in platform UI.
aggregator_node_name = "my-aggregator"
# Collector node name. This will be the name shown in platform UI.
collector_node_name = "my-collector"
# Set this to true to have some initial data in /opt/data on collector. This
# might be useful for quick demonstration.
generate_sample_data = true
