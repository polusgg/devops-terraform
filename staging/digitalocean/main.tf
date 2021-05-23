data "digitalocean_ssh_key" "terraform" {
  name = var.ssh_key_name
}

module "na_west" {
  source = "../../modules/digitalocean/game_region"

  region_slug = var.region_slug
  redis       = {
    name = "redis-na",
    // TODO: Special for North America
    tags = [ "na" ]
  }
  master_node = {
    name = "master-na-west",
    tags = var.digitalocean_tags
  }
  nodes = [
    {
      name = "node-na-west-1",
      tags = var.digitalocean_tags
    },
    {
      name = "node-na-west-2",
      tags = var.digitalocean_tags
    },
    {
      name = "node-na-west-3",
      tags = var.digitalocean_tags
    }
  ]

  ssh_key_ids = [ data.digitalocean_ssh_key.terraform.id ]
  priv_key_file_path = var.priv_key_file_path
}