## Mobile Robot Navigation with an ARTI Robot

## Quick Start
- Connect the computer to the `ARTI Chasi` Wi-Fi
- Open a Terminal and connect to the ARTI Robot (Rpi4) via `ssh ubuntu@192.168.5.3` - password: `ubuntu`
- Start the ros nodes on the Robot with `roslaunch arti_chasi_mark3 arti_chasi_mark3_upstart_with_teleop.launch`
- Open a second Terminal and start the OS1 lidar and Rviz with the launch file in this repository `roslaunch arti_navigation arti_with_os1.launch`
- Switch on the Controller 
