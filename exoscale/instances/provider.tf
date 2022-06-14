terraform {
    required_providers {
        exoscale = {
        source = "exoscale/exoscale"
        version = "0.37.0"
        }
    }
}
provider "exoscale" {
    key = "EXO1c97cfa15b17c4c4280ed2c8"
    secret = "l3-FD5U6T3XEyJ7-yktZ0s2hf6TcqambIs-hl1g070E"
    timeout     = 120
}