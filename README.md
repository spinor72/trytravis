# spinor72_infra
spinor72 Infra repository

## ДЗ №4
#### Самостоятельное задание (слайд 35)
Подключиться через хост bastion можно, например, такого вида командой:
`ssh -i ~/.ssh/appuser -o ProxyCommand="ssh -i ~/.ssh/appuser -W %h:%p appuser@35.204.145.242" appuser@10.164.0.3`

Для подключения простой командой вида `ssh someinternalhost` нужно воспользоваться возможностями файла конфигурации ssh.
Например, создать файл `~/.ssh/config` (если он еще не создан)
и добавить в него содержимое:
```
Host bastion
  Hostname 35.204.145.242
  User appuser
  IdentityFile /home/spa/.ssh/appuser

Host someinternalhost
  Hostname 10.164.0.3
  User appuser
  IdentityFile /home/spa/.ssh/appuser
  ProxyCommand ssh bastion -W %h:%p
```

#### Параметры для проверки:

bastion_IP = 35.204.145.242

someinternalhost_IP = 10.164.0.3
