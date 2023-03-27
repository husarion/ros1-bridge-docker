#!/bin/bash
set -e

# unsetting ROS_DISTRO to silence ROS_DISTRO override warning
unset ROS_DISTRO
# setup ros1 environment
source "/opt/ros/$ROS1_DISTRO/setup.bash" --

# unsetting ROS_DISTRO to silence ROS_DISTRO override warning
unset ROS_DISTRO
# setup ros2 environment
output=$(husarnet-dds singleshot) || true
if [[ "$HUSARNET_DDS_DEBUG" == "TRUE" ]]; then
  echo "$output"
fi

# setup ros environment
source "/opt/ros/$ROS2_DISTRO/setup.bash" --

exec "$@"