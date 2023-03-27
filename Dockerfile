ARG ROS_DISTRO=galactic

FROM ros:$ROS_DISTRO-ros1-bridge

SHELL ["/bin/bash", "-c"]

ENV RMW_IMPLEMENTATION=rmw_fastrtps_cpp

RUN apt update && apt install -y \
        ros-$ROS_DISTRO-rmw-fastrtps-cpp \
        ros-$ROS_DISTRO-rmw-cyclonedds-cpp && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo $(dpkg -s ros-$ROS_DISTRO-ros1-bridge | grep 'Version' | sed -r 's/Version:\s([0-9]+.[0-9]+.[0-9]*).*/\1/g') >> /version.txt

COPY --from=husarnet/ros:humble-ros-core /usr/bin/husarnet-dds /usr/bin/husarnet-dds
RUN chmod +x /usr/bin/husarnet-dds

COPY ros_entrypoint.sh /

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc && \
    echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.profile
