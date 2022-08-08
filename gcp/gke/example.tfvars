# GCP project ID, region and zone you want to deploy resources in.
project = "my-gcp-project-id"
region  = "us-west1"
zone    = "us-west1-b"

# Main name of most of resources, such as VPC, GKE, Cloud SQL...
name = "aparavi"
# Labels to attach to resources
labels = {
  service : "aparavi",
}

# Aparavi platform host in HOSTNAME[:PORT] format
platform_host = "preview.aparavi.com"
# Aparavi platform node ID
platform_node_id = "11111111-aaaa-1111-aaaa-111111111111"
# Appagent node name. This will be the name shown in platform UI. If left
# empty, will default to "${var.name}-appagent", where ${var.name} is the
# value given above to variable 'name'.
appagent_node_name = ""
