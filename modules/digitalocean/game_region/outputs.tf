/*
 *  Redis DB
 */
output "redis_db" {
    description = "Redis DB resource"
    value = module.redis_db
    sensitive = true
}

/*
 *  Loadbalancer
 */
output "master" {
    value = module.master
}

output "domain_record" {
  value = digitalocean_record.this
}

/*
 *  Nodes
 */
output "nodes" {
  value = module.node.*.k
}