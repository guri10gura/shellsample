#!/bin/bash

CUR_FILE=$(basename $0)
CUR_DIR=$(cd $(dirname $0); pwd)

BUILD_DIR="${CUR_DIR}/_build"

function PrintHelp()
{
  echo ""
  echo "${CUR_FILE} options"
  echo "-b --build  build"
  echo "-c --clean  remove build files"
  echo ""
}

function Build()
{
  mkdir -p ${BUILD_DIR}
  pushd ${BUILD_DIR}
  cmake ..
  make
  popd
}

function Clean()
{
  rm -r ${BUILD_DIR}
}

function Run()
{
  PubCommand="${BUILD_DIR}/HelloworldPublisher &"
  echo $PubCommand
  eval $PubCommand
  PubPid=$!

  SubCommand="${BUILD_DIR}/HelloworldSubscriber"
  echo $SubCommand
  eval $SubCommand

  # kill ${PubPid}
}


if [ $# -eq 0 ]; then
  echo "invalid param"
  exit
fi

while true; do
  case "$1" in
    '-b'|'--build')
      Build
      shift; break ;;
    '-c'|'--clean')
      Clean
      shift; break ;;
    '-h'|'--help')
      PrintHelp
      shift; break ;;
    '-r'|'--run')
      Run
      shift; break ;;
  esac
done

