## Mobile Robot Navigation with an ARTI Robot

## Prerequisites
- Install google cartographer with `rosrun arti_navigation install_cartographer.sh` - this 
  This installs as described ["here"](https://google-cartographer-ros.readthedocs.io/en/latest/)
- Use `rosrun arti_navigation configure_terminals.sh` to add the necessary lines to bashrc which source the cartographer_ws and the arti_ws

## Use Cartographer on a Rosbag
- Record a rosbag with the mobile robot
- Start Visualization, Cartographer and Rosbag Playback with `roslaunch arti_navigation start_cartographer_with_rosbag.sh`

## Use Cartographer on live data
### Start the LIDAR with an visualization
- Connect the computer to the `ARTI Chasi` Wi-Fi
- Open a Terminal and connect to the ARTI Robot (Rpi4) via `ssh ubuntu@192.168.5.3` - password: `ubuntu`
- Start the ros nodes on the Robot with `roslaunch arti_chasi_mark3 arti_chasi_mark3_upstart_with_teleop.launch`
- Open a second Terminal and start the OS1 lidar and Rviz with the launch file in this repository `roslaunch arti_navigation arti_with_os1.launch`
- Switch on the Controller 

### Start the map making process with google cartographer
- After the ros nodes on the robot and the os1_lidar with rviz is launched, start the cartograhper ROS node
  with `roslaunch arti_navigation arti_cartographer.launch`