resource "routeros_interface_list_member" "lan_vlan10" {
  interface = routeros_interface_vlan.vlan10.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_vlan" "vlan10" {
  name      = "vlan10"
  vlan_id   = 10
  interface = routeros_interface_bridge.bridge.name
}

resource "routeros_interface_list_member" "lan_vlan20" {
  interface = routeros_interface_vlan.vlan20.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_vlan" "vlan20" {
  name      = "vlan20"
  vlan_id   = 20
  interface = routeros_interface_bridge.bridge.name
}

resource "routeros_interface_list_member" "lan_vlan30" {
  interface = routeros_interface_vlan.vlan30.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_vlan" "vlan30" {
  name      = "vlan30"
  vlan_id   = 30
  interface = routeros_interface_bridge.bridge.name
}