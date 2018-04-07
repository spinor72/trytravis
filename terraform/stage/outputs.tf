output "app_external_ip" {
  value = "${module.app.app_external_ip}"
}

output "db_external_ip" {
  value = "${module.db.db_external_ip}"
}

output "db_internal_ip" {
  value = "${module.db.db_internal_ip}"
}

output "inventory_txt" {
  value = <<EOF
[app]
appserver ansible_host="${module.app.app_external_ip}"

[db]
dbserver ansible_host="${module.db.db_external_ip}"

EOF
}

output "inventory_yml" {
  value = <<EOF
app:
  hosts:
    appserver:
      ansible_host: "${module.app.app_external_ip}"
      db_host: "${module.db.db_internal_ip}"

db:
  hosts:
    dbserver:
      ansible_host: "${module.db.db_external_ip}"
EOF
}

output "inventory_json" {
  value = {
    "app" = {
      "hosts" = [
        "appserver",
      ]
    }

    "db" = {
      "hosts" = [
        "dbserver",
      ]
    }

    "_meta" = {
      "hostvars" = {
        "appserver" = {
          "ansible_host" = "${module.app.app_external_ip}"
        }

        "dbserver" = {
          "ansible_host" = "${module.db.db_external_ip}"
        }
      }
    }
  }
}
