output "redis_op" {
  value = aws_elasticache_cluster.redis
}

output "REDIS_ENDPOINT" {
  value = aws_elasticache_cluster.redis.cache_nodes.0.address
}