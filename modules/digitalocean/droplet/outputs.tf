output "id" {
  description = "DigitalOcean resource ID for the Droplet"
  value = digitalocean_droplet.this.id
}
output "ipv4_addr" {
  description = "Droplet IPv4 address"
  value = digitalocean_droplet.this.ipv4_address
}