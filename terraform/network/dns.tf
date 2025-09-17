resource "routeros_dns" "dns-server" {
  allow_remote_requests = true
  servers = [ "192.168.178.3", "1.1.1.1" ]
}

import {
  to = routeros_ip_dns_record.defconf
  id = "*1"
}
resource "routeros_ip_dns_record" "defconf" {
  name    = "router.lan"
  address = "10.0.0.1"
  type    = "A"
}
