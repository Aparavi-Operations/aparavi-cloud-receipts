name              = "platform-deploy"
key_name          = "aneumyvakin-test"
db_password       = "secr3tPassword"
logstash_endpoint = "logstash-ext.prod.aparavi.com"
subnet_id         = "subnet-0ec1f3281ff641191"
elastic_ip        = "3.141.241.40"
db_subnet_ids     = ["subnet-011eb1fd1a31d8959", "subnet-078f682748858ddd8", "subnet-080aa39ec35d8df74"]

tags = {
  owner = "DevOps"
  label = "test"
}
