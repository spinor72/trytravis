variable app_ip {
  description = "App external ip"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable deploy_app {
  description = "True for deploy app"
  default     = true
}

variable db_ip {
  description = "MongoDB database address to connect app"
  default     = "127.0.0.1"
}
