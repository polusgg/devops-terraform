data "digitalocean_ssh_key" "terraform" {
  name = var.ssh_key_name
}

resource "digitalocean_droplet" "mongodb" {
  name   = "cosmetics-mongodb"
  region = "nyc1"

  // Common configuration
  image  = "mongodb-18-04"
  size   = "s-1vcpu-1gb"
  private_networking = true
  tags = ["cosmetics", "terraform"]
  
  // SSH
  ssh_keys = [ data.digitalocean_ssh_key.terraform.id ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = var.priv_key
    timeout     = "2m"
  }

  // Provisioners
  provisioner "remote-exec" {
    inline = [ "sudo ufw allow 27017" ]
  }
}