1. Run "install_default_programms.sh" script to install default programms and set docker. Logout system (in script).
2. Build 2 images for suitable project (Run "build_server.sh" script):
	- 11.x
	- 12.x
3. Compose suitable project (Run "run_server.sh" script)

Original project: https://github.com/sakaicontrib/docker-sakai



###################################################################	
1. Настройка локального окружения:

- Установить актуальную версию docker.io и docker.compose (install_default_programms.sh)
- Установить уровень доступа sudo для docker (Необходимо выполнить Logout из системы)

###################################################################
2. Создание необходимых контейнеров с образами (build_server.sh):

- Контейнер Tomcat с настройкой параметров:
  * Выполнить "docker -t build tomcat_serv_name ." в каталоге "tomcat" 
  ** "tomcat_serv_name" - произвольное имя контейнера, которое будет присвоено при создании

- Сделать deploy приложения "Sakai" в созданном ранее контейнере для будущего развертывания.
  Процесс занимает порядка 30 минут:
  * Выполнить "docker -t build tomcat_serv_and_sakai ." в каталоге "tomcat-sakai"  
  ** "tomcat_serv_and_sakai" - произвольное имя контейнера, которое будет присвоено при создании
  *** Необходимо в "Dockerfile" (каталог "tomcat-sakai") заменить "FROM tomcat_xxx_xxx" на "FROM tomcat_serv_name".
      "FROM image_name" - берет за основу контейнер с именем "image_name".

###################################################################
3. Развертывание сервера с дополнительным окружением:
   К дополнительному окружению относятся: MySql - БД
										  Adminer - Инструмент, предоставляющий доступ к БД через WEB-интерфейс.

- Выполнить необходимые настройки для каждого их окружений:
  common.yml                - Настройка портов для сервисов и пользозателя для БД.
  placeholder.properties    - Настройка структуры сервиса "Sakai" (Страницы для перехода, ...).

- Запустить необходимые сервисы (run_server.sh). Процесс занимает порядка 5-7 минут:
  * Выполнить "docker-compose up" в каталоге "sakai"
  ** Необходимо в "Dockerfile" (каталог "sakai") заменить "FROM tomcat_xxx" на "FROM tomcat_serv_and_sakai".
     "FROM image_name" - берет за основу контейнер с именем "image_name".
  *** Необходимо в "docker-compose.yml" (каталог "sakai") заменить "image: tomcat_xxx" на "image: tomcat_serv_and_sakai".
      "image: image_name" - берет за основу контейнер с именем "image_name".
  
 
Пример:
127.0.0.1:9090 -        Доступ к Adminer
127.0.0.1:8080/portal - Доступ к Sakai 
 
 ****************************************************************
Дополнительная информация:
1. Как извлечь файлы из docker?
--------------------------------------------------
https://toster.ru/q/407474
Посмотреть список работающих контейнеров:
docker ps -a
Подключение к контейнеру:
docker exec -t -i <container_name> /bin/bash
Смотрится структура директорий, находится где лежит проект и запоминается его путь. Выходим из контейнера

Копируем данные из контейнера:
docker cp <container_name>:<пусть к проекту> <путь куда копируем на текущем сервере>
--------------------------------------------------

2. Размещение образов на Docker Hub:
https://docker.crank.ru/docs/docker-engine/learn-by-example/store-images-on-docker-hub/
https://rtfm.co.ua/docker-dobavit-svoj-obraz-v-repozitorij-na-docker-hub/

3. Руководство по docker(rus) с примерами:
https://habr.com/post/310460/
