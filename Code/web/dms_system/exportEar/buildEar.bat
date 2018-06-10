set JAVA_HOME=D:\primeton\platform\ide\eclipse\jre
set ANT_HOME=D:\primeton\platform\ide\eclipse\plugins\org.apache.ant_1.8.4.v201303080030

set PATH=%PATH%;%JAVA_HOME%/bin;%ANT_HOME%/bin
set CLASSPATH=%CLASSPATH%;%JAVA_HOME%/jre/lib/rt.jar;.

ant -buildfile buildEarWar.xml

pause