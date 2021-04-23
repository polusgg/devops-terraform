output "ipv4_address" {
    value = digitalocean_droplet.docker_droplet.ipv4_address
}

output "ipv4_address_private" {
    value = digitalocean_droplet.docker_droplet.ipv4_address_private
}

output "id" {
    value = digitalocean_droplet.docker_droplet.id
}

output "digitalocean_region_slug" {
    value = digitalocean_droplet.docker_droplet.region
}