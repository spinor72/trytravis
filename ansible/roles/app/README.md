app
=========

configure puma service .

Requirements
------------

puma app server

Role Variables
--------------

db_host should be set to ip of mongodb instance

Dependencies
------------

no

Example Playbook
----------------

    - hosts: apphosts
      roles:
         - { role: app, db_host: 127.0.0.1 }

License
-------

OTUS

Author Information
------------------

spinor72@gmail.com
