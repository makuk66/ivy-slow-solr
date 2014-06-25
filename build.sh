#JAR=ivy-2.3.0.jar
#JAR=y-2.4.0-rc1.jar
# nightly build:
JAR=org.apache.ivy_2.5.0.alpha_20140618062334.jar
# my local build
#JAR=org.apache.ivy_2.5.0.alpha_20140623113200.jar

{
  echo TRYING $JAR
  echo "my.ivy.jar=$JAR" > build.properties
  rm ivy/lib/*.jar
  cp ivys/$JAR ivy/lib/
  ant -v -lib ivy/lib all
} 2>&1 | perl -pne 'use POSIX qw(strftime); print strftime "%Y-%m-%dT%H:%M:%SZ ", gmtime();'
