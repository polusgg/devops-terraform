data "digitalocean_ssh_key" "terraform" {
  name = var.ssh_key_name
}

module "mongodb" {
  source = "../../modules/digitalocean/droplet"

  name = "cosmetics-mongodb"
  region_slug  = "nyc1"
  image = "mongodb-18-04"
  size_slug = "s-1vcpu-1gb"

  tags         = ["cosmetics", "terraform"]

  // SSH Keys
  ssh_key_ids = [ data.digitalocean_ssh_key.terraform.id ]
  priv_key    = var.priv_key
}