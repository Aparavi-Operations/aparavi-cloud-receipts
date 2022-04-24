resource "random_id" "name" {
  byte_length = 2
}

locals {
  # If name_override is specified, use that - otherwise use the name_prefix with a random string
  instance_name        = var.name_override == null ? format("%s-%s", var.name_prefix, random_id.name.hex) : var.name_override
  private_network_name = "private-network-${random_id.name.hex}"
  private_ip_name      = "private-ip-${random_id.name.hex}"
}


module "mysql" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "github.com/gruntwork-io/terraform-google-sql.git//modules/cloud-sql?ref=v0.2.0"
  source = "../modules/cloud-sql"

  project = var.project
  region  = var.region
  name    = local.instance_name
  db_name = var.db_name

  engine       = var.mysql_version
  machine_type = var.machine_type

  # To make it easier to test this example, we are disabling deletion protection so we can destroy the databases
  # during the tests. By default, we recommend setting deletion_protection to true, to ensure database instances are
  # not inadvertently destroyed.
  deletion_protection = false

  # These together will construct the master_user privileges, i.e.
  # 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'.
  # These should typically be set as the environment variable TF_VAR_master_user_password, etc.
  # so you don't check these into source control."
  master_user_password = var.master_user_password

  master_user_name = var.master_user_name
  master_user_host = "%"

  # Pass the private network link to the module
  private_network = google_compute_network.private_network.self_link

  # Wait for the vpc connection to complete
  dependencies = [google_service_networking_connection.private_vpc_connection.network]

  # Set auto-increment flags to test the
  # feature during automated testing
  database_flags = [
    {
      name  = "auto_increment_increment"
      value = "6"
    },
    {
      name  = "auto_increment_offset"
      value = "6"
    },
  ]

  custom_labels = {
    test-id = "mysql-private-ip-example"
  }
}