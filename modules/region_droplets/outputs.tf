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
  value = module.node[*]
}