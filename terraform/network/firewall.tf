import {
  to = routeros_interface_list.wan
  id = "*2000010"
}
resource "routeros_interface_list" "wan" {
  name = "WAN"
}
import {
  to = routeros_interface_list.lan
  id = "*2000011"
}
resource "routeros_interface_list" "lan" {
  name = "LAN"
}

import {
  to = routeros_interface_list_member.wan_ether1
  id = "*2"
}
resource "routeros_interface_list_member" "wan_ether1" {
  interface = "ether1"
  list      = routeros_interface_list.wan.name
}

import {
  to = routeros_interface_list_member.lan_bridge
  id = "*1"
}
resource "routeros_interface_list_member" "lan_bridge" {
  interface = routeros_interface_bridge.bridge.name
  list      = routeros_interface_list.lan.name
}

resource "routeros_ip_firewall_filter" "accept_established_related_untracked" {
  action           = "accept"
  chain            = "input"
  comment          = "accept established, related, untracked"
  connection_state = "established,related,untracked"
  place_before     = routeros_ip_firewall_filter.drop_invalid.id
}
resource "routeros_ip_firewall_filter" "drop_invalid" {
  action           = "drop"
  chain            = "input"
  comment          = "drop invalid"
  connection_state = "invalid"
  place_before     = routeros_ip_firewall_filter.accept_icmp.id
}
resource "routeros_ip_firewall_filter" "accept_icmp" {
  action       = "accept"
  chain        = "input"
  comment      = "accept ICMP"
  protocol     = "icmp"
  place_before = routeros_ip_firewall_filter.capsman_accept_local_loopback.id
}
resource "routeros_ip_firewall_filter" "capsman_accept_local_loopback" {
  action       = "accept"
  chain        = "input"
  comment      = "accept to local loopback for capsman"
  dst_address  = "127.0.0.1"
  place_before = routeros_ip_firewall_filter.drop_all_not_lan.id
}
resource "routeros_ip_firewall_filter" "drop_all_not_lan" {
  action            = "drop"
  chain             = "input"
  comment           = "drop all not coming from LAN"
  in_interface_list = "!LAN"
  place_before      = routeros_ip_firewall_filter.accept_ipsec_policy_in.id
}
resource "routeros_ip_firewall_filter" "accept_ipsec_policy_in" {
  action       = "accept"
  chain        = "forward"
  comment      = "accept in ipsec policy"
  ipsec_policy = "in,ipsec"
  place_before = routeros_ip_firewall_filter.accept_ipsec_policy_out.id
}
resource "routeros_ip_firewall_filter" "accept_ipsec_policy_out" {
  action       = "accept"
  chain        = "forward"
  comment      = "accept out ipsec policy"
  ipsec_policy = "out,ipsec"
  place_before = routeros_ip_firewall_filter.fasttrack_connection.id
}
resource "routeros_ip_firewall_filter" "allow_vlan20_to_internet" {
  action             = "accept"
  chain              = "forward"
  comment            = "allow VLAN20 to WAN"
  in_interface_list  = "LAN"
  src_address        = "10.20.0.0/24"
  out_interface_list = "WAN"
  place_before       = routeros_ip_firewall_filter.fasttrack_connection.id
}
resource "routeros_ip_firewall_filter" "allow_ssh_lan_to_dmz" {
  action            = "accept"
  chain             = "forward"
  comment           = "allow SSH from LAN to DMZ"
  in_interface_list = "LAN"
  out_interface_list = "LAN"
  src_address       = "10.0.0.0/24" 
  dst_address       = "10.30.0.0/24"
  protocol          = "tcp"
  dst_port          = "22"
  place_before      = routeros_ip_firewall_filter.allow_vlan30_to_internet.id
}
resource "routeros_ip_firewall_filter" "allow_vlan30_to_internet" {
  action             = "accept"
  chain              = "forward"
  comment            = "allow VLAN30 to WAN"
  in_interface_list  = "LAN"
  src_address        = "10.30.0.0/24"
  out_interface_list = "WAN"
  place_before       = routeros_ip_firewall_filter.fasttrack_connection.id
}
resource "routeros_ip_firewall_filter" "drop_vlan30_to_lan" {
  action      = "drop"
  chain       = "forward"
  comment     = "drop VLAN30 to LAN"
  src_address = "10.30.0.0/24"
  dst_address = "10.0.0.0/24"
  place_before = routeros_ip_firewall_filter.fasttrack_connection.id
}
resource "routeros_ip_firewall_filter" "fasttrack_connection" {
  action           = "fasttrack-connection"
  chain            = "forward"
  comment          = "fasttrack"
  connection_state = "established,related"
  hw_offload       = "true"
  place_before     = routeros_ip_firewall_filter.accept_established_related_untracked_forward.id
}
resource "routeros_ip_firewall_filter" "accept_established_related_untracked_forward" {
  action           = "accept"
  chain            = "forward"
  comment          = "accept established, related, untracked"
  connection_state = "established,related,untracked"
  place_before     = routeros_ip_firewall_filter.drop_invalid_forward.id
}
resource "routeros_ip_firewall_filter" "drop_invalid_forward" {
  action           = "drop"
  chain            = "forward"
  comment          = "drop invalid"
  connection_state = "invalid"
  place_before     = routeros_ip_firewall_filter.drop_all_wan_not_dstnat.id
}
resource "routeros_ip_firewall_filter" "drop_all_wan_not_dstnat" {
  action               = "drop"
  chain                = "forward"
  comment              = "drop all from WAN not DSTNATed"
  connection_nat_state = "!dstnat"
  connection_state     = "new"
  in_interface_list    = "WAN"
}

import {
  to = routeros_ip_firewall_nat.masquerade
  id = "*1"
}
resource "routeros_ip_firewall_nat" "masquerade" {
  chain              = "srcnat"
  action             = "masquerade"
  ipsec_policy       = "out,none"
  out_interface_list = routeros_interface_list.wan.name
}

resource "routeros_ipv6_settings" "disable" {
  disable_ipv6 = "true"
}
