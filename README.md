# Epam-homework 1
## Весь код:
```
#!/bin/bash

default=`ip r | grep default | awk '{print $5}'`
for interface in $(ip a | grep '<' | awk '{print substr($2, 1, length($2)-1)}')
do
        echo -n -e '\033[0;31m'$interface'\033[0m':'\033[0;35m'$(ip a show $interface | grep inet | grep -v inet6 | awk '{print $2}')'\033[0m'
        for interf in $default
        do
                if [ $interf = $interface ]
                then
                        echo -n -e ':\033[0;32mdefault\033[0m'
                        break
                fi
        done
        echo
done
```
Заносим название стандартных интерфейсов в переменную default:
```
default=`ip r | grep default | awk '{print $5}'`
```
В цикле перебираем все интерфейсы, полученные командой:
```
ip a | grep '<' | awk '{print substr($2, 1, length($2)-1)}'
```
Символ '<' встречается только в строке с интерфейсами, утилита awk возвращает название интерфейса и удаляет символ ':'

Для каждого интерфейса выводим его название и ip, при этом не переносим строку:
```
echo -n -e '\033[0;31m'$interface'\033[0m':'\033[0;35m'$(ip a show $interface | grep inet | grep -v inet6 | awk '{print $2}')'\033[0m'
```
Берем информацию только об одном интерфейсе, выделяем строку с inet с помощью grep и оставляем только ip адрес с помощью awk

Если если интерфейс стандартный, то добавляем в конце слово default, тоже без переноса строки:
```
for interf in $default
do
	if [ $interf = $interface ]
	then
                echo -n -e ':\033[0;32mdefault\033[0m'
		break
	fi
done
```
В конце добавляем перенос строки

Результат выполения скрипта:
```
lo:127.0.0.1/8
enp4s0:
wlp2s0:10.0.0.4/24:default
```
Результат при подключении к маршрутизатору через ethernet:
```
lo:127.0.0.1/8
enp4s0:10.0.0.3/24:default
wlp2s0:10.0.0.4/24:default
```
