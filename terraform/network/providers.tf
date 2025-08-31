terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
}

# TODO via Vault
provider "routeros" {
  hosturl        = "https://10.10.0.1"        
  username       = "terraform"                        
  password       = var.terraform_password                            
  ca_certificate = "/home/david/certs/rb5009.pem" 
  insecure       = false                          
}

resource "routeros_interface_gre" "gre_hq" {
  name           = "gre-hq-1"
  remote_address = "10.77.3.26"
  disabled       = true
}