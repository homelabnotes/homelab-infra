import {
  to = routeros_interface_bridge.bridge
  id = "bridge"
}

resource "routeros_interface_bridge" "bridge" {
  name           = "bridge"
  admin_mac      = "DC:2C:6E:45:CD:5F"
  vlan_filtering = true
}	

import {
  for_each = {
    "ether2"       = { id = "*0" }
    "ether3"       = { id = "*1" }
    "ether4"       = { id = "*2" }
    "ether5"       = { id = "*3" }
    "ether6"       = { id = "*4" }
    "ether7"       = { id = "*5" }
    "ether8"       = { id = "*6" }
    "sfp-sfpplus1" = { id = "*7" }
  }
  to = routeros_interface_bridge_port.bridge_ports[each.key]
  id = each.value.id
}

resource "routeros_interface_bridge_port" "bridge_ports" {
  for_each = {
    "ether2"       = { comment = "LAN", pvid = "10", }
    "ether3"       = { comment = "", pvid = "1" }
    "ether4"       = { comment = "", pvid = "1" }
    "ether5"       = { comment = "MGMT", pvid = "1" }
    "ether6"       = { comment = "", pvid = "1" }
    "ether7"       = { comment = "PROD", pvid = "20" }
    "ether8"       = { comment = "TRUNK", pvid = "20" }
    "sfp-sfpplus1" = { comment = "", pvid = "1" }
  }
  bridge    = routeros_interface_bridge.bridge.name
  interface = each.key
  comment   = each.value.comment
  pvid      = each.value.pvid
}