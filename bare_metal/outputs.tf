/*
 *  Database
 */
output "redis_db" {
    value = module.redis_db
    sensitive = true
}

/*
 *  Loadbalancer
 */
output "master-na-west" {
    value = module.master-na-west
}

output "na-west-fip" {
  value = digitalocean_floating_ip.na-west-fip.ip_address
}

output "na-west-domain" {
  value = digitalocean_record.na-west-domain
}


/*
 *  Nodes
 */
output "node-na-west-1" {
    value = module.node-na-west-1
}

output "node-na-west-2" {
    value = module.node-na-west-2
}

output "node-na-west-3" {
    value = module.node-na-west-3
}