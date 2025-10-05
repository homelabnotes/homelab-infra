# ===============================================

# Interface Lists

# ===============================================

resource "routeros_interface_list" "wan" {
  name = "WAN"
}

resource "routeros_interface_list" "lan" {
  name = "LAN"
}

resource "routeros_interface_list_member" "wan_ether1" {
  interface = "ether1"
  list = routeros_interface_list.wan.name
}

resource "routeros_interface_list_member" "lan_bridge" {
  interface = routeros_interface_bridge.bridge.name
  list = routeros_interface_list.lan.name
}

# ===============================================
# Firewall Filters
# ===============================================

# INPUT Chain

resource "routeros_ip_firewall_filter" "accept_established_related_untracked" {
  action = "accept"
  chain = "input"
  comment = "accept established, related, untracked"
  connection_state = "established,related,untracked"
}

resource "routeros_ip_firewall_filter" "drop_invalid" {
  action = "drop"
  chain = "input"
  comment = "drop invalid"
  connection_state = "invalid"
}

resource "routeros_ip_firewall_filter" "accept_icmp" {
  action = "accept"
  chain = "input"
  comment = "accept ICMP"
  protocol = "icmp"
}

resource "routeros_ip_firewall_filter" "capsman_accept_local_loopback" {
  action = "accept"
  chain = "input"
  comment = "accept to local loopback for CAPsMAN"
  dst_address = "127.0.0.1"
}

resource "routeros_ip_firewall_filter" "drop_all_not_lan" {
  action = "drop"
  chain = "input"
  comment = "drop all not coming from LAN"
  in_interface_list = "!LAN"
}

# FORWARD Chain

resource "routeros_ip_firewall_filter" "accept_established_related_untracked_forward" {
  action = "accept"
  chain = "forward"
  comment = "accept established, related, untracked"
  connection_state = "established,related,untracked"
}

resource "routeros_ip_firewall_filter" "drop_invalid_forward" {
  action = "drop"
  chain = "forward"
  comment = "drop invalid"
  connection_state = "invalid"
}

resource "routeros_ip_firewall_filter" "fasttrack_connection" {
  action = "fasttrack-connection"
  chain = "forward"
  comment = "fasttrack"
  connection_state = "established,related"
  hw_offload = "true"
}

resource "routeros_ip_firewall_filter" "accept_ipsec_policy_in" {
  action = "accept"
  chain = "forward"
  comment = "accept in IPsec policy"
  ipsec_policy = "in,ipsec"
}

resource "routeros_ip_firewall_filter" "accept_ipsec_policy_out" {
  action = "accept"
  chain = "forward"
  comment = "accept out IPsec policy"
  ipsec_policy = "out,ipsec"
}

# VLAN → WAN

resource "routeros_ip_firewall_filter" "allow_vlan20_to_internet" {
  action = "accept"
  chain = "forward"
  comment = "allow VLAN20 to WAN"
  in_interface_list = "LAN"
  src_address = "10.20.0.0/24"
  out_interface_list = "WAN"
}

resource "routeros_ip_firewall_filter" "allow_vlan30_to_internet" {
  action = "accept"
  chain = "forward"
  comment = "allow VLAN30 to WAN"
  in_interface_list = "LAN"
  src_address = "10.30.0.0/24"
  out_interface_list = "WAN"
}

resource "routeros_ip_firewall_filter" "drop_vlan30_to_lan" {
  action = "drop"
  chain = "forward"
  comment = "drop VLAN30 to LAN"
  src_address = "10.30.0.0/24"
  dst_address = "10.0.0.0/24"
}

# LAN → DMZ

resource "routeros_ip_firewall_filter" "allow_lan_to_dmz" {
  action = "accept"
  chain = "forward"
  comment = "allow LAN to DMZ"
  src_address = "192.168.178.0/24"
  dst_address = "10.30.0.0/24"
}

# WAN → DMZ (FritzBox hairpin)

resource "routeros_ip_firewall_filter" "allow_fritzbox_to_dmz_dns_tcp" {
  action = "accept"
  chain = "forward"
  comment = "Allow FritzBox Net to AdGuard (TCP) in DMZ"
  in_interface_list = "WAN"
  src_address = "192.168.178.0/24"
  dst_address = "10.30.0.2"
  protocol = "tcp"
  dst_port = "53"
}

resource "routeros_ip_firewall_filter" "allow_fritzbox_to_dmz_dns_udp" {
  action = "accept"
  chain = "forward"
  comment = "Allow FritzBox Net to AdGuard (UDP) in DMZ"
  in_interface_list = "WAN"
  src_address = "192.168.178.0/24"
  dst_address = "10.30.0.2"
  protocol = "udp"
  dst_port = "53"
}

resource "routeros_ip_firewall_filter" "allow_fritzbox_to_dmz_http" {
  action = "accept"
  chain = "forward"
  comment = "Allow FritzBox Net to NPM (HTTP)"
  in_interface_list = "WAN"
  src_address = "192.168.178.0/24"
  dst_address = "10.30.0.2"
  protocol = "tcp"
  dst_port = "80"
}

resource "routeros_ip_firewall_filter" "allow_fritzbox_to_dmz_https" {
  action = "accept"
  chain = "forward"
  comment = "Allow FritzBox Net to NPM (HTTPS)"
  in_interface_list = "WAN"
  src_address = "192.168.178.0/24"
  dst_address = "10.30.0.2"
  protocol = "tcp"
  dst_port = "443"
}

resource "routeros_ip_firewall_filter" "allow_fritzbox_to_dmz_minecraft_tcp" {
  action = "accept"
  chain = "forward"
  comment = "Allow FritzBox Net to Minecraft (TCP)"
  in_interface_list = "WAN"
  src_address = "192.168.178.0/24"
  dst_address = "10.30.0.2"
  protocol = "tcp"
  dst_port = "25565"
}

resource "routeros_ip_firewall_filter" "allow_fritzbox_to_dmz_minecraft_udp" {
  action = "accept"
  chain = "forward"
  comment = "Allow FritzBox Net to Minecraft (UDP)"
  in_interface_list = "WAN"
  src_address = "192.168.178.0/24"
  dst_address = "10.30.0.2"
  protocol = "udp"
  dst_port = "25565"
}

# ===============================================
# Firewall NAT
# ===============================================

resource "routeros_ip_firewall_nat" "masquerade" {
  chain = "srcnat"
  action = "masquerade"
  ipsec_policy = "out,none"
  out_interface_list = routeros_interface_list.wan.name
}

# Portforwards WAN → DMZ

resource "routeros_ip_firewall_nat" "forward_http_to_npm" {
  action = "dst-nat"
  chain = "dstnat"
  comment = "Forward HTTP to NPM"
  in_interface_list = "WAN"
  protocol = "tcp"
  dst_port = "80"
  to_addresses = "10.30.0.2"
  to_ports = "80"
}

resource "routeros_ip_firewall_nat" "forward_https_to_npm" {
  action = "dst-nat"
  chain = "dstnat"
  comment = "Forward HTTPS to NPM"
  in_interface_list = "WAN"
  protocol = "tcp"
  dst_port = "443"
  to_addresses = "10.30.0.2"
  to_ports = "443"
}

resource "routeros_ip_firewall_nat" "forward_minecraft_to_pi" {
  action = "dst-nat"
  chain = "dstnat"
  comment = "Forward Minecraft to Pi"
  in_interface_list = "WAN"
  protocol = "tcp"
  dst_port = "25565"
  to_addresses = "10.30.0.2"
  to_ports = "25565"
}

# DNS Redirect WAN → AdGuard

resource "routeros_ip_firewall_nat" "redirect_wan_dns_to_adguard_tcp" {
  action = "dst-nat"
  chain = "dstnat"
  comment = "Redirect DNS queries from WAN interface to AdGuard (TCP)"
  in_interface_list = "WAN"
  dst_address = "192.168.178.10"
  protocol = "tcp"
  dst_port = "53"
  to_addresses = "10.30.0.2"
  to_ports = "53"
}

resource "routeros_ip_firewall_nat" "redirect_wan_dns_to_adguard_udp" {
  action = "dst-nat"
  chain = "dstnat"
  comment = "Redirect DNS queries from WAN interface to AdGuard (UDP)"
  in_interface_list = "WAN"
  dst_address = "192.168.178.10"
  protocol = "udp"
  dst_port = "53"
  to_addresses = "10.30.0.2"
  to_ports = "53"
}

# ===============================================
# Disable IPv6
# ===============================================

resource "routeros_ipv6_settings" "disable" {
  disable_ipv6 = "true"
}

resource "routeros_ip_firewall_filter" "drop_all_wan_not_dstnat" {
  action               = "drop"
  chain                = "forward"
  comment              = "Drop all from WAN not DSTNATed"
  connection_nat_state = "!dstnat"
  connection_state     = "new"
  in_interface_list    = "WAN"
}

resource "routeros_ip_firewall_nat" "forward_mysterium_udp_to_pi" {
  action            = "dst-nat"
  chain             = "dstnat"
  comment           = "Forward Mysterium UDP ports to Pi"
  in_interface_list = "WAN"
  protocol          = "udp"
  dst_port          = "10000-60000"
  to_addresses      = "10.30.0.2"
  to_ports          = "10000-60000"
}

resource "routeros_ip_firewall_filter" "allow_wan_to_mysterium_udp" {
  action               = "accept"
  chain                = "forward"
  comment              = "Allow forwarded WAN traffic to Mysterium UDP"
  connection_nat_state = "dstnat"
  in_interface_list    = "WAN"
  dst_address          = "10.30.0.2"
  protocol             = "udp"
  dst_port             = "10000-60000"
  place_before         = routeros_ip_firewall_filter.drop_all_wan_not_dstnat.id
}