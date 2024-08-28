#! /bin/bash

#-Dversant.db.host=172.17.0.2 -Dversant.db.name=dps_integration



function exec() {
  echo "Use: $@"
  #$@ || exit 1  
}

function run_against_docker_container_overriding_version() {
  exec "mvn clean install -PIT  $JAVA_OPTS -D<version property A>=<version value> -D<version property B>=<version value>"     
  echo  
  exec "e.g. mvn clean install -PIT  $JAVA_OPTS -DERICsharedtesttool_CXP0000000=1.0.124-SNAPSHOT"     
}

function run_against_docker_container() {
  exec "mvn clean install -PIT  $JAVA_OPTS"     
}  

function start_docker_env(){
  exec "./testsuite/docker-start.sh"
}

function stop_docker_env(){
  exec "./testsuite/docker-stop.sh"
}


print_help() {
      echo "use: $0 <option>"
      echo "      where option could be:"
      echo "      -rd  |--start-docker-environment                    show command to start docker environment"       
      echo "      -sd  |--stop-docker-environment                     show command to stop docker environment"       
      echo "      -tdc |--test-docker-container                       show command to run vertical slice against a docker container"       
      echo "      -tdcs|--test-docker-container-against-snapshot      show command to run vertical slice against a docker container overriding dependency version"       
}

[ $# -eq 0 ] &&  print_help
while [ $# -gt 0 ]; do
  echo
  case $1 in
    -rd|--start-docker-environment)
      start_docker_env
      ;;
    -sd|--stop-docker-environment)
      stop_docker_env
      ;;
    -tdc|--test-docker-container)
      run_against_docker_container
      ;;
    -tdcs|--test-docker-container-against-snapshot)
      run_against_docker_container_overriding_version
      ;;
    -h|--help|*)
      print_help
      ;; 
  esac
  shift
done

echo
