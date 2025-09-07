import {
    to = routeros_ip_pool.dhcp
    id = "*1"
}
resource "routeros_ip_pool" "dhcp" {
  name   = "default-dhcp"
  ranges = ["10.10.0.10-10.10.0.254"]
}

import {
    to = routeros_ip_dhcp_server_network.dhcp
    id = "*1"
}
resource "routeros_ip_dhcp_server_network" "dhcp" {
  address    = "10.10.0.0/24"
  gateway    = "10.10.0.1"
  dns_server = ["10.10.0.1"]
}

import {
    to = routeros_ip_dhcp_server.defconf
    id = "*1"
}
resource "routeros_ip_dhcp_server" "defconf" {
  name         = "defconf"
  address_pool = routeros_ip_pool.dhcp.name
  interface    = routeros_interface_bridge.bridge.name
}
