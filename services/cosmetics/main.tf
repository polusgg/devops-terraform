/*
 *  SSH Keys
 */
data "digitalocean_ssh_key" "terraform" {
  name = var.ssh_key_name
}
resource "local_file" "ssh_priv_key" {
  content = var.priv_key
  filename = "${path.root}/id_ed25519_polusgg_terraform"
  file_permission = "0600"
}

/*
 *  Resources
 */

resource "digitalocean_droplet" "cosmetics_web" {
  name   = "cosmetics-web-1"
  region = "nyc3"

  // Common configuration
  image  = "docker-20-04"
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
    inline = [ "sudo ufw allow 2219/tcp" ]
  }
}



/*
 *  Docker
 */
resource "docker_image" "cosmetics" {
  client {
    host = "ssh://root@${digitalocean_droplet.cosmetics_web.ipv4_address}:22"
    private_key = local_file.ssh_priv_key.filename
    registry_address  = "registry.digitalocean.com"
    registry_username = var.digitalocean_registry_token
    registry_password = var.digitalocean_registry_token
  }

  name = var.docker_image
}

resource "docker_container" "cosmetics" {
  client {
    host = "ssh://root@${digitalocean_droplet.cosmetics_web.ipv4_address}:22"
    private_key = local_file.ssh_priv_key.filename
    registry_address  = "registry.digitalocean.com"
    registry_username = var.digitalocean_registry_token
    registry_password = var.digitalocean_registry_token
  }

  image   = docker_image.cosmetics.latest
  name    = "server-cosmetics"
  env     = [
    "STEAM_PUBLISHER_KEY=${var.steam_publisher_key}",
    "ACCOUNT_AUTH_TOKEN=${var.accounts_auth_token}",
    "DATABASE_URL=${var.mongodb_url}",
    "CA_CERT_PATH=./ca-certificate-pggcosmetics.crt"
  ]
  restart = "always"
  ports {
    internal = 2219
    external = 2219
    protocol = "tcp"
  }
}


/*
 *  Project Assignment
 */
data "digitalocean_project" "this" {
  name = "Polus.gg Web"
}
resource "digitalocean_project_resources" "this" {
  project = data.digitalocean_project.this.id
  resources = [
    digitalocean_droplet.cosmetics_web.urn
  ]
}