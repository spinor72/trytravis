module "app_host" {
  source = "../modules/ansible"
  name   = "apphost"
  host   = "${module.app.app_external_ip}"
  groups = ["app"]

  vars = {
    "db_host" = "${module.db.db_internal_ip}"
    "db_port" = "27017"
  }
}

module "db_host" {
  source = "../modules/ansible"
  host   = "${module.db.db_external_ip}"
  name   = "dbhost"
  groups = ["db"]
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
  value = <<EOF
{
    "app": {
      "hosts" : ["appserver"],
      "vars" : { 
        "db_host" : "${module.db.db_internal_ip}"}
      },

    "db" : {
      "hosts" : ["dbserver"]
    },

    "_meta" : {
      "hostvars" : {
        "appserver" : {
          "ansible_host" : "${module.app.app_external_ip}"
        },

        "dbserver" : {
          "ansible_host" : "${module.db.db_external_ip}"
        }
      }
    }
}
  EOF
}
