export JAVA_HOME="D:\primeton\platform\ide\eclipse\jre"
export ANT_HOME="D:\primeton\platform\ide\eclipse\plugins\org.apache.ant_1.8.4.v201303080030"
export PATH="${PATH}:${JAVA_HOME}/bin:${ANT_HOME}/bin"
export CLASSPATH="${CLASSPATH}:${JAVA_HOME}/jre/lib/rt.jar"
ant -buildfile buildEarWar.xml