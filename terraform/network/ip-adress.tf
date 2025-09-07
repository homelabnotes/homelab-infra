import {
  to = routeros_ip_address.lan
  id = "*1"
}
resource "routeros_ip_address" "lan" {
  address   = "10.10.0.1/16"
  interface = routeros_interface_bridge.bridge.name
  network   = "10.10.0.0"
}

import {
  to = routeros_ip_dhcp_client.wan
  id = "*1"
}
resource "routeros_ip_dhcp_client" "wan" {
  interface = "ether1"
}
