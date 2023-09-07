#!/bin/bash

# Detect the Linux distribution and package manager
if [ -f /etc/os-release ]; then
    source /etc/os-release
    LINUX_DISTRO=$ID
    PACKAGE_MANAGER=
    if [ "$LINUX_DISTRO" == "ubuntu" ] || [ "$LINUX_DISTRO" == "debian" ]; then
        PACKAGE_MANAGER="apt-get"
    elif [ "$LINUX_DISTRO" == "centos" ] || [ "$LINUX_DISTRO" == "rhel" ]; then
        PACKAGE_MANAGER="yum"
    else
        echo "Unsupported Linux distribution: $LINUX_DISTRO"
        exit 1
    fi
else
    echo "Unable to detect the Linux distribution."
    exit 1
fi

# Install Git
echo "Installing Git..."
sudo $PACKAGE_MANAGER update -y
sudo $PACKAGE_MANAGER install git -y

# Install Tomcat
echo "Installing Tomcat..."
sudo $PACKAGE_MANAGER install tomcat -y

# Create and deploy HelloWorld web application
echo "Creating HelloWorld web application..."
sudo mkdir -p /var/lib/tomcat/webapps/HelloWorld
echo "<html><body><h1>Hello, World!</h1></body></html>" | sudo tee /var/lib/tomcat/webapps/HelloWorld/index.html

# Start Tomcat service
echo "Starting Tomcat..."
sudo systemctl start tomcat

# Enable Tomcat to start on boot
sudo systemctl enable tomcat

# Check Tomcat status
echo "Tomcat status:"
sudo systemctl status tomcat
