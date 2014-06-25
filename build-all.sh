{
for jar in \
  ivy-2.3.0.jar \
  ivy-2.4.0-rc1.jar \
  org.apache.ivy_2.5.0.alpha_20140618062334.jar \
  org.apache.ivy_2.5.0.alpha_20140623113200.jar; do
  echo
  echo TRYING $jar
  echo "my.ivy.jar=$jar" > build.properties
  date
  rm ivy/lib/*.jar
  cp ivys/$jar ivy/lib/
  ant -lib ivy/lib clean
  ant -v -lib ivy/lib
  echo DONE $jar
  date
done

} 2>&1 | perl -pne 'use POSIX qw(strftime); print strftime "%Y-%m-%dT%H:%M:%SZ ", gmtime();'
