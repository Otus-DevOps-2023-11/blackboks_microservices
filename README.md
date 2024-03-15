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
* Второе задание со :star: - создан какталог infra, в packer собран шаблон с установленным docker, в terrafrom создан модуль docker c провижионером remote-exec, который выполняет сценарий запуска контейнера с приложением на созданных инстансах (реализовать динамический inventory c ansible и плагина yc-compute не получилось)
