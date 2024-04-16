## ДЗ 13 - Docker контейнеры. Docker под капотом

### Было сделано:

* Установлен docker 25.0.4, плагин docker-compose
* Запущен контейнер с hello-world -- docker run hello-world
* Дополнительно протестированы комманды docker run -it, -d, attach, start, exec, image commit
* Первое задание со :star: - описана разница между образом и контейнером
* Протестированы команды docker kill, stop, system df, rm, rmi
* Создан docker host в YC
* Создан docker image и загружен на docker hub  bbks/otus-reddit:1.0
* Выолнены различные проверки
* Второе задание со :star: - создан какталог infra, в packer собран шаблон с установленным docker, в terrafrom создан модуль docker c провижионером remote-exec, который выполняет сценарий запуска контейнера с приложением на созданных инстансах (реализовать динамический inventory c ansible и плагином yc-compute не получилось)



## ДЗ 14 - Docker-образы. Микросервисы

### Было сделано:

* Создан каталог scr, в который помещен код компонентов приложения
* Созданы Dockerfile для каждого из компонентов
* Собраны docker image для каждого из компонентов
* Протестирована работа приложения
* Улучшен образ ui компонента
* Задание со :star: - создан образ comment и ui компонетов на базе alpine:3.14
* Создан volume reddit_db для контейнера с mongodb
* Проверена работа приложения


## ДЗ 15 - Сетевое взаимодействие Docker контейнеров. Docker Compose. Тестирование образов

### Было сделано:

* Произведен запуск контейнеров с сетевыми драйверами none, host, bridge
* Произведен запуск контейнеров с импользованием сетевых алиасов
* Произведен запуск контейнеров разных сетях
* Установлен docker compose, создан файл docker-compose.yml, запущены контейнеры
* Изменен файл docker-compose для использования нескольких сетей
* Создан .env файл, добавлены переменные
* Базовое имя проекта формируется по имени каталога, в котором находится docker-copose.yml файл. Дополнительно имя проекта можно задать использую переменную COMPOSE_PROJECT_NAME, верхнеуровневый атрибут name: в файле docker-compose.yaml, флаг -p при запуске проекта
* Задание со :star: - в контейнеры добавлены волумы с исходным кодом компонентов, чтобы иметь возможность вносить изменения в код без пересборки образа, добавлены команды для запуска puma в debug режиме с двумя воркерами


## ДЗ 16 - Устройство Gitlab CI. Построение процесса непрерывной поставки

### Было сделано:

* Задание со :star: - С помощью packer на основе ОС ubuntu18 создан образ для будущей ВМ с gitlab, в terraform создан модуль для развертывания ВМ для gitlab с использованием образа packer из предыдущего шага, в ansible созданы роли для установки docker (использовалась готовая роль geerlingguy.docker) и gitlab. Для роли gitlab создан docker-compose.yml
* В развернутом инстансе gitlab создан группа homework и проект example
* Добавлен файл .gitlab-ci.yml
* Добавлен внешний раннер
* Добавлены файлы проекта reddit, тесты в пайплайне и динамические окружения

![image](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/d763e839-8917-40c8-89f5-5e4914f8fd62)

![image](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/a25ac224-3c3c-4d0b-9c9e-2d3ecf8d7389)


## ДЗ 17 - Системы мониторинга

### Было сделано:

* В YC с помощью  terraform (добавлен модуль для prometheus) создана ВМ из образа диска для gitlab из предыдущего задания
* Создана ansible роль для развертывания prometheus в docker контейнере, сам docker так же установлен через ansible роль geerlingguy.docker
* Протестирован веб интерфейс prometheus, развернутого на ВМ в YC
* В локальном репозитории создан Dockerfile для prometheus и файл конфигурации prometheus.yml в каталоге monitoring/prometheus
* Собран образ bbks/prometheus:latest
* Пересобраны образы каждого из сервисов с использованием скриптов docker_build.sh
* Сервис prometheus добавлен в основной docker-compose.yml файл
* Протестированы таргеты, метрики для сервисов
* Добавлен экспортер node-exporter в основной docker-compose.yml, отредактирован prometheus.yml, пересобран образ prometheus
* Пересозданы сервисы, протестированы эндпоинты и метрики
* Созданные образы отправлены в dockerhub
https://hub.docker.com/r/bbks/post
https://hub.docker.com/r/bbks/ui
https://hub.docker.com/r/bbks/comment
https://hub.docker.com/r/bbks/prometheus
* Задание со :star: #1 - В docker-compose.yml и в prometheus.yml добавлен porcona/mongodb_exporter:0.40, пересобран образ prometheus
* Задание со :star: #2 -  docker-compose.yml и в prometheus.yml добавлен blackbox-exporter, пересобран образ prometheus, допонительно создан Dockerfile для blackbox-exporter, собран образ https://hub.docker.com/r/bbks/blackbox-exporter. Использованы модули http_2xx и icmp_ttl5 для тестирования экспортера
