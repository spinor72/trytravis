provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["${var.source_ip_allowed}"]
}

module "app" {
  source           = "../modules/app"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  app_disk_image   = "${var.app_disk_image}"
}

module "db" {
  source           = "../modules/db"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  db_disk_image    = "${var.db_disk_image}"
}

module "deploy" {
  source           = "../modules/deploy"
  private_key_path = "${var.private_key_path}"
  db_ip            = "${module.db.db_internal_ip}"
  app_ip           = "${module.app.app_external_ip}"
  deploy_app       = "${var.deploy_app}"
}
