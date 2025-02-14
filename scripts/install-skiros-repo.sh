#!/bin/bash

# Repository
REPO=https://github.com/Bjarne-AAU/skiros-demo.git
ROS=melodic

# Usage
function print-help
{
	echo "Usage: ./install folder"
}

# Args parser
function check-params
{
  if [ $# -lt 1 ]; then
	  echo "Not enough arguments provided"
	  print-help
	  exit -1
  fi
}

function install-special-dependencies
{
  ./src/skiros2/skiros2/skiros2/scripts/install_fd_task_planner.sh $1
}


# import tools
SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $SCRIPT/tools.sh

check-params $*
install-pkgs git ros-$ROS-ros python-catkin-tools
download-repo $REPO $1
cd $1
install-repo-dependencies $ROS
install-special-dependencies
add-source-to-bash "/opt/ros/$ROS/setup.bash"
build-repo
add-source-to-bash "`pwd`/devel/setup.bash"
bash
