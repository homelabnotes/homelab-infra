resource "routeros_interface_bridge" "bridge" {
  name           = "bridge"
  admin_mac      = "DC:2C:6E:45:CD:5F"
}

resource "routeros_interface_bridge_port" "bridge_ports" {
  for_each = {
    "ether2"       = { comment = "", pvid = "1" }
    "ether3"       = { comment = "", pvid = "1" }
    "ether4"       = { comment = "", pvid = "1" }
    "ether5"       = { comment = "", pvid = "1" }
    "ether6"       = { comment = "", pvid = "1" }
    "ether7"       = { comment = "", pvid = "1" }
    "ether8"       = { comment = "", pvid = "1" }
    "sfp-sfpplus1" = { comment = "", pvid = "1" }
  }
  bridge    = routeros_interface_bridge.bridge.name
  interface = each.key
  comment   = each.value.comment
  pvid      = each.value.pvid
}
