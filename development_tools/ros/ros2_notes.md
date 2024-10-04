# Install
- Follow instructions here to install ros2: (https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html)[https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html]
# Commands 
## Nodes 
- ros2 run <package_name> <executable_name> 
- ros2 node list 
- ros2 run turtlesim turtlesim_node --ros-args --remap __node:=my_turtle 
- ros2 node info <node_name> 
- rqt_graph -> good visualization of nodes, topics, etc. 
## Topics 
- ros2 topic list –t –displays rostopic topics with their type 
- ros2 topic echo /topicname 
- ros2 topic info /turtle1/cmd_vel – shows the message type and # of subscribers and publishers 
- ros2 interface show geometry_msgs/msg/Twist - > shows interface for messages 
- ros2 topic pub <topic_name> <msg_type> '<args>' - args need to be in YAML syntax 
- ros2 topic pub --rate 1 /turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 1.8}}" 
- Publishes at 1 Hz
- ros2 topic hz /turtle1/pose 
## Services
These are single call type actions (spawn a turtle, for example) 
- ros2 service list -t 
- ros2 service type <service_name> 
- ros2 service find <type_name> 
- ros2 service find std_srvs/srv/Empty 
- ros2 interface show <type_name>.srv 
- ros2 interface show turtlesim/srv/Spawn 
- ros2 service call <service_name> <service_type> <arguments> 
- ros2 service call /spawn turtlesim/srv/Spawn "{x: 2, y: 2, theta: 0.2, name: ''}" 
## Parameters 
- ros2 param list 
- ros2 param get <node_name> <parameter_name> 
	- ros2 param get /turtlesim background_g 
- ros2 param set <node_name> <parameter_name> <value> 
	- ros2 param set /turtlesim background_r 150 
- ros2 param dump <node_name> -> this dumps the current parameter values into a file to use later 
	- ros2 param dump /turtlesim 
- ros2 param load <node_name> <parameter_file> -> loads parameters to a currently running node 
	- ros2 param load /turtlesim ./turtlesim.yaml 
- ros2 run <package_name> <executable_name> --ros-args --params-file <file_name> -> this starts a node with saved parameter values 
	- ros2 run turtlesim turtlesim_node --ros-args --params-file turtlesim.yaml 

## Actions 
Similar to services, except you can cancel them while executing, and they provide steady feedback, as opposed to services which return a single response. 
- ros2 node info /turtlesim -> this will list the node’s subscribers, publishers, services, action servers, and action clients 
- ros2 action list –t -> displays all actions in the ROS graph 
- ros2 action info /turtle1/rotate_absolute -> shows slients and servers of action 
- ros2 interface show turtlesim/action/RotateAbsolute 
- ros2 action send_goal <action_name> <action_type> <values> 
- ros2 action send_goal /turtle1/rotate_absolute turtlesim/action/RotateAbsolute "{theta: 1.57}" --feedback 
## Launch 
- ros2 launch turtlesim multisim.launch.py -> used to start up and configure a number of executables containing ROS 2 nodes simultaneously 
## Recording and Playing Back Data 
- ros2 bag record –o subset /turtle1/cmd_vel /turtle1/pose 
	- If you want all topics use the –a flag 
- ros2 bag info subset 
- ros2 bag play subset 
## Creating a Workspace 
- Best practice to put packages in the src directory of the worksopace 
- From workspace root run the following to install dependencies 
	- rosdep install -i --from-path src --rosdistro foxy –y  
- Building workspace: from root of workspace run 
	- colcon build 
	- To clean workspace: rm -rf build install log 
## Creating a Package 
- A package is a container for ROS 2 code. ROS 2 uses ament as its build system and colcon as its build tool. 
- File structure: 
	- my_package/ 
		- CMakeLists.txt -> contains meta info about package 
		- package.xml -> describes how to build code in package 
- A single workspace can contain as many packages as you want each in their own folder 
	- all packages should live in src folder 
		- workspace_folder/ 
			- src/ 
				- package_1/ 
					- CMakeLists.txt 
					- package.xml 
				- package_2/ 
					- CMakeLists.txt 
					- package.xml
- ros2 pkg create --build-type ament_cmake <package_name> -> to create a package 
	- ros2 pkg create --build-type ament_cmake --node-name my_node my_package -> This creates a simple hello world type executable in the package 
- To build only your package from root of workspace: 
	- colcon build --packages-select my_package 
- After building, source workspace by the following: 
	- . install/setup.bash from the root of the workspace 
# Writing a Publisher and Subscriber 
See examples here: https://docs.ros.org/en/foxy/Tutorials/Writing-A-Simple-Cpp-Publisher-And-Subscriber.html 

# Writing a Simple Service and Client 
See examples here: https://docs.ros.org/en/foxy/Tutorials/Writing-A-Simple-Cpp-Service-And-Client.html 

# Creating Custom msg and srv files 
See examples here: https://docs.ros.org/en/foxy/Tutorials/Custom-ROS2-Interfaces.html 

# Actions 
- https://docs.ros.org/en/foxy/Tutorials/Actions/Creating-an-Action.html 
- https://docs.ros.org/en/foxy/Tutorials/Actions/Writing-a-Cpp-Action-Server-Client.html 
# TF2 
ros2 run tf2_tools view_frames.py -> This will make a pdf with the TF tree

# Intraprocess Communication via Composable Nodes
- See [here](https://docs.ros.org/en/humble/Tutorials/Intermediate/Writing-a-Composable-Node.html) for a tutorial
- Instead of communicating normally through 