import {
  to = routeros_ip_address.lan
  id = "*1"
}
resource "routeros_ip_address" "lan" {
  address   = "10.0.0.1/24"
  interface = routeros_interface_bridge.bridge.name
  network   = "10.0.0.0"
}

import {
  to = routeros_ip_dhcp_client.wan
  id = "*1"
}
resource "routeros_ip_dhcp_client" "wan" {
  interface = "ether1"
}

resource "routeros_ip_address" "vlan10" {
  address   = "10.10.0.1/24"
  interface = routeros_interface_vlan.vlan10.name
  network   = "10.10.0.0"
}

resource "routeros_ip_address" "vlan20" {
  address   = "10.20.0.1/24"
  interface = routeros_interface_vlan.vlan20.name
  network   = "10.20.0.0"
}

resource "routeros_ip_address" "vlan30" {
  address   = "10.30.0.1/24"
  interface = routeros_interface_vlan.vlan30.name
  network   = "10.30.0.0"
}