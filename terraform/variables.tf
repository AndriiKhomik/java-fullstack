variable "react_app_api_base_url" {
  description = "REACT_APP_API_BASE_URL"
  type        = string
}

variable "postgres_user" {
  description = "POSTGRES_USER"
  type        = string
  sensitive   = true
}

variable "postgres_password" {
  description = "POSTGRES_PASSWORD"
  type        = string
  sensitive   = true
}

variable "postgres_db" {
  description = "POSTGRES_DB"
  type        = string
  sensitive   = true
}

variable "postgres_port_internal" {
  description = "Postrges port internal"
  type        = string
  sensitive   = true
}

variable "postgres_port_external" {
  description = "Postrges port external"
  type        = string
  sensitive   = true
}

variable "redis_port_internal" {
  description = "Redis port internal"
  type        = string
  sensitive   = true
}

variable "redis_port_external" {
  description = "Redis port external"
  type        = string
  sensitive   = true
}

variable "mongo_initdb_root_username" {
  description = "MONGO_INITDB_ROOT_USERNAME"
  type        = string
  sensitive   = true
}

variable "mongo_initdb_root_password" {
  description = "MONGO_INITDB_ROOT_PASSWORD"
  type        = string
  sensitive   = true
}

variable "mongodb_port_internal" {
  description = "Mongodb port internal"
  type        = string
  sensitive   = true
}

variable "mongodb_port_external" {
  description = "Mongodb port external"
  type        = string
  sensitive   = true
}

variable "mongodb_local_current_database" {
  description = "MONGO_LOCAL_CURRENT_DATABASE"
  type        = string
  sensitive   = true
}

variable "default_server_cluster" {
  description = "DEFAULT_SERVER_CLUSTER"
  type        = string
  sensitive   = true
}
