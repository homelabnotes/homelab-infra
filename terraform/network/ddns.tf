resource "routeros_ip_cloud" "cloud" {
  ddns_enabled         = "yes"
  update_time          = true
  ddns_update_interval = "1m"
} 

output "mikrotik_cloud_dns_name" {
  value       = routeros_ip_cloud.cloud.dns_name
  description = "Mikrotik Dynamic Name"
}