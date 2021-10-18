# Script to install google cartographer
# https://google-cartographer-ros.readthedocs.io/en/latest/compilation.html#system-requirements
# Armin Niedermüller

# Install wstool and rosdep.
sudo apt-get update
sudo apt-get install -y python-wstool python-rosdep ninja-build stow

# Create a new workspace in 'catkin_ws'.
mkdir cartographer_ws
cd cartographer_ws
wstool init src

# Merge the cartographer_ros.rosinstall file and fetch code for dependencies.
wstool merge -t src https://raw.githubusercontent.com/cartographer-project/cartographer_ros/master/cartographer_ros.rosinstall
#wstool merge -t src /home/rosdev/carto.rosinstall
wstool update -t src

# Install deb dependencies.
# The command 'sudo rosdep init' will print an error if you have already
# executed it since installing ROS. This error can be ignored.
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

# Install specific protobuf - ROS KINETIC ONLY
bash src/cartographer/scripts/install_proto3.sh

# Remove Systems abseil lib and install cartographer specific one
sudo apt-get remove ros-${ROS_DISTRO}-abseil-cpp
bash src/cartographer/scripts/install_abseil.sh

# Build and install.
catkin_make_isolated --install --use-ninja
source install_isolated/setup.bash
