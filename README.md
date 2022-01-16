# Epam-homework 1
## Весь код:
```
#!/bin/bash

echo '$interfaceName:$IPaddress:$default'
default=`ip r | grep default | awk '{print $5}'`
for interface in $(ip a | grep '<' | awk '{print substr($2, 1, length($2)-1)}')
do
        echo -n $interface:$(ip address show $interface | grep inet | grep -v inet6 | awk '{print $2}')
        if [ $default = $interface ]
        then
                echo :default
        else
                echo
        fi
done
```
Заносим название стандартного интерфейса в переменную default:
```
default=`ip r | grep default | awk '{print $5}'`
```
В цикле перебираем все интерфейсы, полученные командой:
```
ip a | grep '<' | awk '{print substr($2, 1, length($2)-1)}'
```
Символ '<' встречается только в строке с интерфейсами, утилита awk возвращает название интерфейса удаляет символ ':'

Для каждого интерфейса выводим его название и ip, при этом не переносим строку:
```
echo -n $interface:$(ip address show $interface | grep inet | grep -v inet6 | awk '{print $2}')
```
Берется информация только об одном интерфейсе, выделяем строку с inet с помощью grep и оставляем только ip адресс с помощью awk

Если если интерфейс стандартный, то добавляем в конце слово default, иначе перевод строки:
```
if [ $default = $interface ]
        then
                echo :default
        else
                echo
fi
```
Результат выполения скрипта:
```
$interfaceName:$IPaddress:$default
lo:127.0.0.1/8
enp4s0:
wlp2s0:10.0.0.4/24:default
```
