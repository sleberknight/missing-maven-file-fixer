#!/bin/bash
find . -name *.pom -exec ./make-sha1.sh {} \;
find . -name *.jar -exec ./make-sha1.sh {} \;
