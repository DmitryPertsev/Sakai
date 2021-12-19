#!/bin/bash

(cd tomcat; docker build -t tomcat_8537_8111 .)
(cd tomcat-sakai; docker build -t tomcat_8537_8111_12x .)

