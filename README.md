db
=========

Configure mongodb server

Requirements
------------

mongodb server installed

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

License
-------

OTUS

Author Information
------------------

spinor72@gmail.com
