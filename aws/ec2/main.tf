module "aparavi-ec2" {
  source = "../../modules/aws/aparavi-ec2"

  KEY_NAME                 = var.KEY_NAME
  MANAGEMENT_NETWORK       = var.MANAGEMENT_NETWORK
  PLATFORM                 = var.PLATFORM
  PARENT_ID                = var.PARENT_ID
  DEPLOYMENT               = var.DEPLOYMENT
  collector_instance_count = var.collector_instance_count
}
