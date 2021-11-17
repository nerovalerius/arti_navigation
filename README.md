# Mobile Robot Navigation with an ARTI Chasi Mk3 Robot

## Prerequisites
- Install google cartographer with `rosrun arti_navigation install_cartographer.sh` - this installs cartographer ROS as described [[here]](https://google-cartographer-ros.readthedocs.io/en/latest/)
- Use `rosrun arti_navigation configure_terminals.sh` to add the necessary lines to bashrc which source the cartographer_ws and the arti_ws

## _Point and Click_ - Robot Navigation
The robot navigation is set up using the [ROS Navigation Stack](http://wiki.ros.org/navigation). To navigate, the robot needs to locate itself inside a given or even creates a new map while locating itself in it. This problem is also known as SLAM (simultaneous location and mapping). For SLAM, either [gmapping](http://wiki.ros.org/gmapping) or [cartographer](http://wiki.ros.org/cartographer) can be used. This ros package uses cartographer by default. This can changed by either calling the move_base launch file with the parameters `gmapping:=true / cartographer=false` or simply changing them inside [move_base.launch](https://github.com/nerovalerius/arti_navigation/blob/master/launch/move_base.launch). By default, cartographer is used.

#### Start Navigation

Use the following commands to start the robot and the navigation:
- Connect the computer to the `ARTI Chasi` Wi-Fi
- Open a Terminal and connect to the ARTI Robot (Rpi4) via `ssh ubuntu@192.168.5.3` - password: `ubuntu`
- Start the ros nodes on the Robot with `roslaunch arti_chasi_mark3 arti_chasi_mark3_upstart_with_teleop.launch`
- Open a second Terminal and start the navigation stack, together with the OS1 lidar, Rviz and cartographer: `roslaunch arti_navigation move_base.launch`
- Inside Rviz click on `2D Nav Goal` on the upper menu and click on the position in the 2D map where you want the robot to navigate to.
  
## Map Creation with Cartographer
### Use Cartographer on a Rosbag
- Record a rosbag with the mobile robot
- Start Visualization, Cartographer and Rosbag Playback with `roslaunch arti_navigation start_cartographer_with_rosbag.sh`

### Use Cartographer on live data
#### Start the LIDAR with an visualization
- Connect the computer to the `ARTI Chasi` Wi-Fi
- Open a Terminal and connect to the ARTI Robot (Rpi4) via `ssh ubuntu@192.168.5.3` - password: `ubuntu`
- Start the ros nodes on the Robot with `roslaunch arti_chasi_mark3 arti_chasi_mark3_upstart_with_teleop.launch`
- Open a second Terminal and start the OS1 lidar and Rviz: `roslaunch arti_navigation arti_with_os1.launch`
- Switch on the Controller 

#### Start the map making process with google cartographer
After the ros nodes on the robot and the os1_lidar with rviz is launched, start the cartograhper ROS node with 

`roslaunch arti_navigation arti_cartographer.launch`

#### Saving the map
To store the processed data of google cartographer, please use the following commands while the cartographer node is still running:

- `rosservice call /finish_trajectory 0`
- `rosservice call /write_state robxtask_1.pbstream true`
- `rosrun map_server map_saver -f robxtask_1`
- `mv .ros/robxtask_1.pbstream ~`

This map can then later be used for localization only purposes. The *.yaml file has to be given as parameter for the map server `arti_navigation/launch/move_base.launch`
and 

## Tuning and Configuration
### Important Files
- [**arti_2d.lua**](https://github.com/nerovalerius/arti_navigation/blob/master/cartographer_ros/configuration_files/arti_2d.lua)
    - contains the configuration for google cartographer.
There are some crucial parameters to set and optimize, otherwise the map creation and navigation fails. See [[lua configuration]](https://google-cartographer-ros.readthedocs.io/en/latest/configuration.html) and [[cartographer tuning]](https://google-cartographer-ros.readthedocs.io/en/latest/tuning.html).
- [**move_base.launch**](https://github.com/nerovalerius/arti_navigation/blob/master/cartographer_ros/configuration_files/arti_2d.lua)
    - `gmapping` - set to true to use gmapping instead of cartographer
    - `cartographer` - set to true to use cartographer instead of gmapping
    - `rviz` - activate visualization with Rviz
    - `map` - runs the map server with a predefined map 
- [**tajectory_planner.yaml**](https://github.com/nerovalerius/arti_navigation/blob/master/config/trajectory_planner.yaml)
    - Different parameters can be altered to optimize the navigation behavior of the robot.
      See [[costmap_2d]](http://wiki.ros.org/costmap_2d) and [[navigation stack setup]](http://wiki.ros.org/navigation/Tutorials/RobotSetup).
- [**common_costmap_params.yaml**](https://github.com/nerovalerius/arti_navigation/blob/master/cartographer_ros/configuration_files/arti_2d.lua)
    - See [[costmap_2d]](http://wiki.ros.org/costmap_2d) and [[navigation stack setup]](http://wiki.ros.org/navigation/Tutorials/RobotSetup).
- [**global_costmap_params.yaml**](https://github.com/nerovalerius/arti_navigation/blob/master/cartographer_ros/configuration_files/arti_2d.lua)
    - See [[costmap_2d]](http://wiki.ros.org/costmap_2d) and [[navigation stack setup]](http://wiki.ros.org/navigation/Tutorials/RobotSetup).
- [**local_costmap_params.yaml**](https://github.com/nerovalerius/arti_navigation/blob/master/cartographer_ros/configuration_files/arti_2d.lua)
    - See [[costmap_2d]](http://wiki.ros.org/costmap_2d) and [[navigation stack setup]](http://wiki.ros.org/navigation/Tutorials/RobotSetup).


