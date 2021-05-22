resource "digitalocean_droplet" "this" {
  name   = var.name
  region = var.region_slug

  // Common configuration
  image  = var.image
  size   = var.size_slug
  private_networking = true
  tags = var.tags
  
  // SSH
  ssh_keys = ssh_key_ids
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.priv_key_file_path)
    timeout     = "2m"
  }

  // Provisioners
  provisioner "remote-exec" {
    command = "sudo ufw allow 22023/udp"
  }
}