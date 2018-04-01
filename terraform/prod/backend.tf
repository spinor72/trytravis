terraform {
  backend "gcs" {
    bucket = "storage-bucket-spinor-test"
    prefix = "terraform/state"
  }
}
