variable zone {
  description = "Zone"
  default     = "europe-west4-c"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the public key used for ssh access"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable machine_type {
  description = "Machine type"
  default     = "g1-small"
}
