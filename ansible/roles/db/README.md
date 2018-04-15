db
=========
[![Build Status](https://travis-ci.org/spinor72/infra-role-db.svg?branch=master)](https://travis-ci.org/spinor72/infra-role-db)

Install and configure mongodb server

Requirements
------------

-

Role Variables
--------------

mongo_port port for mongodb to listen 
mongo_bind_ip ip-address for mongodb to listen 

Dependencies
------------

-

Example Playbook
----------------

    - hosts: dbhosts
      roles:
         - { role: db, mongo_port: 27017, mongo_bind_ip: 192.168.0.11 }


Test role
----------------
Role contains tests with molecule
default is local vagrant driver

For remote test with gce driver use --scenario-name travis option
and command like 
`USER=travis GCE_SERVICE_ACCOUNT_EMAIL='<service-account>@<project-id>.iam.gserviceaccount.com'  GCE_CREDENTIALS_FILE="$(pwd)/credentials.json" GCE_PROJECT_ID='<project-id>' molecule  destroy --scenario-name travis`
 

Travis CI is configured to make test in GCE

License
-------

-

Author Information
------------------

spinor72@gmail.com
