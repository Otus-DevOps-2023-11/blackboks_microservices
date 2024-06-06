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
* Созданные образы отправлены в dockerhub:
 - https://hub.docker.com/r/bbks/post
 - https://hub.docker.com/r/bbks/ui
 - https://hub.docker.com/r/bbks/comment
 - https://hub.docker.com/r/bbks/prometheus
* Задание со :star: #1 - В docker-compose.yml и в prometheus.yml добавлен porcona/mongodb_exporter:0.40, пересобран образ prometheus

![image](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/394f50de-3c14-483e-9816-c245e8408862)

* Задание со :star: #2 - В docker-compose.yml и в prometheus.yml добавлен blackbox-exporter, пересобран образ prometheus, допонительно создан Dockerfile для blackbox-exporter, собран образ https://hub.docker.com/r/bbks/blackbox-exporter. Использованы модули http_2xx и icmp_ttl5 для тестирования экспортера

![image](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/3f518a67-84af-4ba3-b8ce-a968580c7c3a)

![image](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/981ae9e5-cba9-474e-9332-e771ba5872f3)



## ДЗ 18 - Системы логирования

### Было сделано:

* Пересобраны контейнеры с тэгом logging
* Запущен EFK стэк для работы с логами
* Протестирован fluentd с фильтрами regexp и grok
* Протестирована визуализация логов в kibana
* Протестирован сервис распределенного трейсинга Zipkin


## ДЗ 19 - Знакомство с Kubernetes

### Было сделано:

* Созданы манифесты для компонентов приложения в kubernetes/reddit
* Вручную установлены компоненты кластера - containerd, kubelet, kubeadm, kubectl
* Инициализирован кластер kubernetes версии 1.28.9
* Установлен CNI Calico  с pod cidr 10.244.0.0/16
* Задание со :star: - Кластер kubernetes версии 1.28.9 создан с помощью packer, terraform, ansible. В packer создан образ на основе Ubuntu 22.04, в terraform созданы модули master и node, в которых описаны настройки ВМ, развернуты 3 ВМ, 1 мастер, 2 воркера. В ansible созданый роли containerd и k8scluster. Containerd подготавливает ВМ для установки CR, устанавливает containderd, настраивает конфигурацию. K8scluster добавляет новые репозитории, устанавливает основные компоненты кластера, добавляет ноды в кластер.

* ![image](https://github.com/Otus-DevOps-2023-11/blackboks_infra/assets/28865449/17c286f8-9685-4756-90c3-18df6d2f00de)
* ![image](https://github.com/Otus-DevOps-2023-11/blackboks_infra/assets/28865449/c5afeefb-d89c-4abe-984c-391c3cb0cdfc)


## ДЗ 20 - Kubernetes. Запуск кластера и приложения.

### Было сделано:

* Установлен minikube
* В minikube запущены компоненты проложения
* Добавлены сервисы для компонентов приложения
* Добавлены переменные окружения для comment и post подов
* Создана служба с типом NodePort для ui компонента
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_infra/assets/28865449/720e42fc-bea4-4eab-bebe-64b9ac472784)
* Создан namespace dev
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_infra/assets/28865449/cc60c949-da01-44d2-88d6-44b8f88852e9)
* Вручную развернут кластер в YC, произведен деплой приложения
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_infra/assets/28865449/8c36fbfc-a5fb-493d-bb75-981f02cbe877)
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_infra/assets/28865449/e4a41be2-8ec5-48f6-b89e-bebf1912cbf0)
* Задание со :star: - создан модуль k8s для terrafom, позволяющий развернуть кластер в автоматическом режиме, добавлен манифест для дашборда с доступом по NodePort
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_infra/assets/28865449/30a88bf3-7014-4157-8968-0aeec911d316)


## ДЗ 21 - Kubernetes. Сетевые настройки, ingresss, storages.

### Было сделано:

* Протестированы сервисы NodePort, LoadBalancer
* Установлен Ingress-controller nginx
* Создан ingress манифест для ui сервиса
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_infra/assets/28865449/afbc6e37-a8fa-4f8f-9a5e-d6accebe6f69)
* Создан самоподписанный сертификат, добавлен с ingress
  ![Снимок экрана от](https://github.com/Otus-DevOps-2023-11/blackboks_infra/assets/28865449/3639c141-0ef1-40a2-83c9-a8a934c3f437)
* Задание со :star: - сертификат добавлен в виде манифеста cert.yml
* Настроены network policy для компонентов comment и post
* Создан отдельный диск в YC, добавлены манифести для PersistentVolume и PersistentVolumeClaim с использованием нового диска в YC
* В деплоймент mongodb добавлен persistentVolumeClaim
  ![Снимок экрана от 2024-05-04 14-15-10](https://github.com/Otus-DevOps-2023-11/blackboks_infra/assets/28865449/09291f36-5239-4823-9667-08c54eebd292)


## ДЗ 22 - CI/CD в Kubernetes

### Было сделано:

* В terraform создан модуль для добавления maneged kubernetes кластера в YC(2 воркера, 1 мастер), поднят кластер
* Установлен Helm версии 3.15
* Созданы helm чарты для компонентов приложения, шаблонизированы манифесты, определены значения values
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/510f782b-225e-4f47-902e-95d9f77391a1)
* Созданы  _helpers.tpl файлы для всех компонентов приложения
* Добавлен отдельный чарт reddit для управления зависимостями
* Установлен ingress-controller
* В кластер установлен чарт gitlab-omnibus
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/07b300b4-d9f7-4b2e-96f9-a5852a815948)
* Добавлены группа, проекты, переменные
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/c9bdfece-939a-4781-8285-af164a92e58c)
* Настроен первоначальный вариант .gitlab-ci.yml
* В репозиторий ui добавлена ветка feature3, так же добавлены дополнительные стейджи в .gitlab-ci.yml
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/325f4ef0-357e-4e35-9749-97030335f410)
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/3f04dad0-e557-4a36-ae93-1508249b1046)
* Файл .gitlab-ci.yml распространен по другим репозиториям компонентов приложения, для репозитория reddit-deploy создан отдельный файл для деплоя на staging и production
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/964824a2-3c83-42f6-bb70-93019030d0e1)
  ![Снимок экрана](https://github.com/Otus-DevOps-2023-11/blackboks_microservices/assets/28865449/bf1b7a27-e426-49fd-be56-4ab87db63624)
