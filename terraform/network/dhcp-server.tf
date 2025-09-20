import {
    to = routeros_ip_pool.dhcp
    id = "*1"
}
resource "routeros_ip_pool" "dhcp" {
  name   = "default-dhcp"
  ranges = ["10.0.0.10-10.0.0.254"]
}

import {
    to = routeros_ip_dhcp_server_network.dhcp
    id = "*1"
}
resource "routeros_ip_dhcp_server_network" "dhcp" {
  address    = "10.0.0.0/24"
  gateway    = "10.0.0.1"
  dns_server = ["10.0.0.1"]
}

import {
    to = routeros_ip_dhcp_server.defconf
    id = "*1"
}
resource "routeros_ip_dhcp_server" "defconf" {
  name         = "defconf"
  address_pool = routeros_ip_pool.dhcp.name
  interface    = routeros_interface_bridge.bridge.name
  disabled = false
}

resource "routeros_ip_pool" "vlan10_pool" {
  name   = "vlan10-dhcp"
  ranges = ["10.10.0.10-10.10.0.254"]
}

resource "routeros_ip_dhcp_server" "vlan10" {
  name         = "vlan10-dhcp"
  address_pool = routeros_ip_pool.vlan10_pool.name
  interface    = routeros_interface_vlan.vlan10.name
  disabled     = false
}

resource "routeros_ip_dhcp_server_network" "vlan10" {
  address    = "10.10.0.0/24"
  gateway    = "10.10.0.1"
  dns_server = ["10.10.0.1"]
}

resource "routeros_ip_pool" "vlan20_pool" {
  name   = "vlan20-dhcp"
  ranges = ["10.20.0.10-10.20.0.254"]
}

resource "routeros_ip_dhcp_server" "vlan20" {
  name         = "vlan20-dhcp"
  address_pool = routeros_ip_pool.vlan20_pool.name
  interface    = routeros_interface_vlan.vlan20.name
  disabled     = false
}

resource "routeros_ip_dhcp_server_network" "vlan20" {
  address    = "10.20.0.0/24"
  gateway    = "10.20.0.1"
  dns_server = ["10.20.0.1"]
}