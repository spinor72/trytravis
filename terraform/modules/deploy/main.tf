resource "null_resource" "app" {
  count = "${var.deploy_app ? 1 : 0}"

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    host        = "${var.app_ip}"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo DATABASE_URL=${var.db_ip} > /home/appuser/.env",
    ]
  }

  provisioner "file" {
    source      = "${path.module}/files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}
