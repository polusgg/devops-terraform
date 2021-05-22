/*
 *  Droplet
 */

// Corresponds to the "Terraform" public key on DigitalOcean
data "digitalocean_ssh_key" "terraform_mark" {
  name = "Terraform (Mark)"
}

data "digitalocean_ssh_key" "terraform_cody" {
  name = "Terraform (Cody)"
}

resource "digitalocean_droplet" "docker_droplet" {
  name   = var.droplet_name
  region = var.digitalocean_region_slug

  // Common configuration
  image  = var.digitalocean_droplet_image
  size   = var.digitalocean_droplet_size
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.terraform_mark.id,
    data.digitalocean_ssh_key.terraform_cody.id
  ]
  tags = var.digitalocean_region_tags
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.digitalocean_priv_key_file)
    timeout     = "2m"
  }
  provisioner "local-exec" {
    command = "sudo ufw allow 22023/udp"
  }
}