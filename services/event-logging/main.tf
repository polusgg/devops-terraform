/*
 *  Resources
 */
resource "digitalocean_database_cluster" "mongodb" {
  name       = "mongodb-event-logging"
  engine     = "mongodb"
  version    = "4"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc3"
  node_count = 1
  tags = ["event-logging", "terraform"]
}

resource "digitalocean_record" "this" {
  domain = "polus.gg"
  type   = "A"
  name   = "event-logging.mongo.service"
  value  = digitalocean_database_cluster.mongodb.host
}

/*
 *  Project Assignment
 */
data "digitalocean_project" "this" {
  name = "Polus.gg Services"
}
resource "digitalocean_project_resources" "this" {
  project = data.digitalocean_project.this.id
  resources = [
    digitalocean_database_cluster.mongodb.urn
  ]
}