#!/bin/bash
# Script to setup and Ubuntu laptop with common tools/apps

function apps() { #resp1
    echo -e "\e[00;36m \nInstalling core tools... \e[00m"
    sudo apt-get install -y git-core
    sudo apt-get install -y curl
    sudo apt-get install -y python3-pip
    sudo apt-get install -y gcovr

    echo -e "\e[00;36m \nInstalling terminal tools... \e[00m"
    sudo apt-get install -y terminator # Preferred terminal with splits etc.
    sudo apt-get install -y tree # Cool command to view directory structure

    echo -e "\e[00;36m \nInstalling common text editors... \e[00m"
    # Visual Studio Code
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt-get install code
    pip3 install pylint
    pip3 install yapf

    echo -e "\e[00;36m \nInstalling Zoom... \e[00m"
    wget https://zoom.us/client/latest/zoom_amd64.deb
    sudo apt install ./zoom_amd64.deb
    return
}

function git_setup() { #resp2
    echo -e "\e[00;36m \nSetting git config... \e[00m"

    read -p "Git username: " user_name
    read -p "Git email: " user_email
    ssh-keygen -t rsa -b 4096 -C "$user_email"
    git config --global user.name "$user_name"
    git config --global user.email "$user_email"
    git config --global credential.helper cache
    git config --global credential.helper 'cache --timeout=3600'

    return
}

function chrome_setup() { #resp3
    echo -e "\e[00;36m \nInstalling Google Chrome... \e[00m"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb
    return
}

function get_ros_distro_name() {
    . /etc/os-release
    release=`echo $UBUNTU_CODENAME`
    
    if [ "$release" == "focal" ]; then
        echo "foxy"
    elif [ "$release" == "jammy" ]; then
        echo "humble"
    else
        echo ""
    fi
}

function ros2_setup() { #resp4
    echo -e "\e[00;36m \nInstalling ROS2... \e[00m"
    ros_distro=`get_ros_distro_name`
    
    sudo apt update && sudo apt install locales
    sudo locale-gen en_US en_US.UTF-8
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8

    if [ "$ros_distro" == "foxy" ]; then

        sudo apt update && sudo apt install curl gnupg2 lsb-release
        sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
        sudo apt update
        sudo apt install -y ros-foxy-desktop

    elif [ "$ros_distro" == "humble" ]; then
        sudo apt install software-properties-common
        sudo add-apt-repository universe
        sudo apt update && sudo apt install curl -y
        sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
        sudo apt update
        sudo apt upgrade
        sudo apt install ros-humble-desktop
    else
        echo "Invalid ros_distro: $ros_distro"
        return 
    fi

    sudo apt install -y python3-argcomplete

    # TODO: Remove colcon install when it is included in the desktop install
    sudo apt install python3-colcon-common-extensions
    ros_development_tool
    sudo pip3 install pyqtgraph==0.11.0
    sudo pip3 install gitpython
    rosdep update

    return
}

function ros2_extras() { #resp4_1
    echo -e "\e[00;36m \nInstalling additional ROS2 packages... \e[00m"
    ros_distro=`get_ros_distro_name`
    sudo apt install -y ros-$ros_distro-rqt
    sudo apt install -y ros-$ros_distro-joint-state-publisher
    sudo apt install -y ros-$ros_distro-joint-state-publisher-gui
    sudo apt install -y ros-$ros_distro-moveit
    sudo apt install -y ros-$ros_distro-moveit-servo
    sudo apt install -y ros-$ros_distro-ros2-control
    sudo apt install -y ros-$ros_distro-ros2-controllers
    sudo apt install -y ros-$ros_distro-octomap
    sudo apt install -y ros-$ros_distro-xacro
}

function ros_development_tool() {
    # Part of the official ros development setup
    # https://index.ros.org/doc/ros2/Installation/Crystal/Linux-Development-Setup/#install-development-tools-and-ros-tools
    echo -e "\e[00;36m \nInstalling ROS Development Tools... \e[00m"
    sudo apt update && sudo apt install -y \
    build-essential \
    cmake \
    git \
    python3-colcon-common-extensions \
    python3-pip \
    python3-rosdep2 \
    python3-vcstool \
    wget
    # install some pip packages needed for testing
    python3 -m pip install -U \
    transforms3d \
    argcomplete \
    flake8 \
    flake8-blind-except \
    flake8-builtins \
    flake8-class-newline \
    flake8-comprehensions \
    flake8-deprecated \
    flake8-docstrings \
    flake8-import-order \
    flake8-quotes \
    pytest-repeat \
    pytest-rerunfailures \
    pytest \
    pytest-cov \
    pytest-runner \
    setuptools
    # install Fast-RTPS dependencies
    sudo apt install --no-install-recommends -y \
    libasio-dev \
    libtinyxml2-dev
    # install Cyclone DDS dependencies
    sudo apt install --no-install-recommends -y \
    libcunit1-dev

    return
}

function gazebo_setup() { #resp5
    echo -e "\e[00;36m \nInstalling Gazebo... \e[00m"
    
    ros_distro=`get_ros_distro_name`

    if [ "$ros_distro" == "foxy" ]; then
        # Install gazebo11
        sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
        wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
        sudo apt-get update
        sudo apt-get install gazebo11
        sudo apt-get install libgazebo11-dev

        # Install gazebo ros packages
        sudo apt-get install ros-foxy-gazebo-ros-pkgs
        sudo apt install ros-foxy-gazebo-ros2-control
    elif [ "$ros_distro" == "humble" ]; then
        sudo apt-get install ros-humble-ros-gz
        sudo apt install ros-humble-gazebo-ros2-control
    fi

    # Create directory where gazebo looks for models
    if  [ ! -d ~/.gazebo/models ]; then
        mkdir -p ~/.gazebo/models
    fi

    return
}

read -p "Press any key to run Ubuntu configuration script, or CTRL-C to cancel"

read -p "Install common apps? (y/n) " resp1
read -p "git setup? (y/n) " resp2
read -p "Install Google Chrome? (y/n) " resp3
read -p "Install ROS2? (y/n) " resp4
if [ "$resp4" = "y" ]; then
    read -p "Install additional ROS2 packages such as rqt, moveit, ros2-control? (y/n) " resp4_1
fi
read -p "Install Gazebo simulation tools? (y/n) " resp5

if [ "$resp1" = "y" ]; then
    apps
fi

if [ "$resp2" = "y" ]; then
    git_setup
fi

if [ "$resp3" = "y" ]; then
    chrome_setup
fi

if [ "$resp4" = "y" ]; then
    ros2_setup
    if [ "$resp4_1" = "y" ]; then
        ros2_extras
    fi
fi

if [ "$resp5" = "y" ]; then
    gazebo_setup
fi

read -p "Cleanup? (y/n) " resp0
if [ "$resp0" = "y" ]; then
    echo -e "\e[00;36m \nCleaning up... \e[00m"
    sudo apt-get autoremove -y
    sudo apt-get dist-upgrade -y
    sudo apt-get clean
fi
