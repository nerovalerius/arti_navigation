# Configures the .bashrc file for the correct use with ROS on ARTI Chasi
# Armin Niedermüller

#ROS Workspace Settings - ARTI Chasi
echo "" >> ~/.bashrc
echo "#ROS Settings - ARTI Workspaces" >> ~/.bashrc
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
echo "source ~/arti_ws/devel/setup.bash" >> ~/.bashrc 
echo "source ~/cartographer_ws/install_isolated/setup.bash" >> ~/.bashrc

#ROS Network Settings - ARTI Chasi
echo "" >> ~/.bashrc
echo "#ROS Network Settings" >> ~/.bashrc
echo "export ROS_IP=192.168.5.5" >> ~/.bashrc
echo "export ROS_MASTER_URI=http://192.168.5.3:11311/" >> ~/.bashrc
echo "export | grep ROS_ | awk '{print $3}'" >> ~/.bashrc
echo "echo ROS Environment Settings \($BASH_SOURCE\):" >> ~/.bashrc

echo "/.bashrc successfully changed!"