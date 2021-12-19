#!/bin/bash

(cd tomcat; docker build -t tomcat_server_8028 .)
(cd tomcat-sakai; docker build -t tomcat_sakai_11x .)

