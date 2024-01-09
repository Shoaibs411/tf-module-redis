# Provisioning Redis Cluster
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.default.name
  engine_version       = "6.x"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
}

# Parameter Group
resource "aws_elasticache_parameter_group" "default" {
  name   = "cache-params"
  family = "redis6.x"
}

# Creates Subnet Group
resource "aws_elasticache_subnet_group" "redis" {
  name       = "roboshop-${var.ENV}-redis-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
}