#!/bin/bash


# Starts everything which is needed to tune the google cartographer - runs with a rosbag file
# Armin Niedermüller

echo "Google Cartographer ROS Tuning"

echo "Please enter a rosbag filename:"
read rosbag_filename

# Check if rosbag exists
if ! test -f "$rosbag_filename"; then
    echo "file $rosbag_filename does not exist."
    exit 1
fi

echo "Starting roscore"
gnome-terminal -e "roscore"
sleep 3

echo "Setting ROS Sim time true"
rosparam set /use_sim_time true
sleep 1

echo "Starting Google Cartographer ROS"
gnome-terminal -e "roslaunch arti_navigation arti_cartographer.launch"
sleep 2

echo "Starting Rviz"
gnome-terminal -e "roslaunch arti_navigation arti_with_os1.launch"
sleep 2

echo "Starting Rosbag Playback: $rosbag_filename"
rosbag play --clock $rosbag_filename
sleep 1