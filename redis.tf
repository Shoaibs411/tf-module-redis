# Provisioning Redis Cluster
resource "aws_elasticache_cluster" "redis" {
  cluster_id            = "roboshop-${var.ENV}-redis"
  engine                = "redis"
  node_type             = var.REDIS_ENGINE
  num_cache_nodes       = 1
  parameter_group_name  = aws_elasticache_parameter_group.default.name
  engine_version        = var.REDIS_ENGINE_VERSION
  port                  = var.REDIS_PORT
  subnet_group_name     = aws_elasticache_subnet_group.redis.name
  security_group_ids    = [aws_security_group.allows_redis.id]
}

# Parameter Group
resource "aws_elasticache_parameter_group" "default" {
  name                  = "cache-params"
  family                = var.REDIS_ENGINE_FAMILY
}

# Creates Subnet Group
resource "aws_elasticache_subnet_group" "redis" {
  name                  = "roboshop-${var.ENV}-redis-subnet-group"
  subnet_ids            = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
}


