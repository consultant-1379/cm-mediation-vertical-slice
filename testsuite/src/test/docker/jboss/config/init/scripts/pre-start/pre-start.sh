#! /bin/bash
#
# ebialan
# 
# 
source docker-env-functions.sh

#Increase resources on Jenkins to be faster
if [ "$RUNNING_ENV" = "JENKINS" ]; then
  echo "Jenkins configuration ..."      
  cat $DOCKER_DEFAULT_JVM_PROPERTIES_SCRIPT | grep -v -e ms512m -e mx2g -e PermSize > jvm.tmp
  mv jvm.tmp $DOCKER_DEFAULT_JVM_PROPERTIES_SCRIPT
fi

cleanup_deployment
copy_jboss_config

ls -la $JBOSS_HOME/standalone/deployments

#TODO: install TP resolver in jboss-mediation image
$JBOSS_HOME/bin/pre-start/tp-resolver-dependency.sh
cat  /opt/ericsson/jboss/modules/com/ericsson/oss/mediation/resolver/extensions/main/module.xml


mkdir -p /home/smrs/
find $DOCKER_INIT_DIR -name "CORE17TCU02001.xml" -exec cp {} /home/smrs \;
find $DOCKER_INIT_DIR -name "CORE16SIU02001.xml" -exec cp {} /home/smrs \;

wait_dps_integration

