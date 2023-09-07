#!/bin/bash

# Create HelloWorldApp directory and index.html file
mkdir HelloWorldApp
echo "<html><body><h1>Hello, World!</h1></body></html>" > HelloWorldApp/index.html

# Check Linux Distribution
if [[ -f /etc/redhat-release ]]; then
   DISTRO="redhat"
elif [[ -f /etc/debian_version ]]; then
   DISTRO="debian"
else
   echo "Unsupported Linux distribution"
   exit 1
fi

# Install Tomcat based on the detected distribution
if [[ "$DISTRO" == "redhat" ]]; then
   sudo yum install -y tomcat
elif [[ "$DISTRO" == "debian" ]]; then
   sudo apt-get install -y tomcat9
fi

# Deploy HelloWorldApp to Tomcat
sudo cp -r HelloWorldApp /var/lib/tomcat/webapps/

# Start Tomcat
sudo systemctl start tomcat

# Enable Tomcat to start on boot
sudo systemctl enable tomcat

# Check if Tomcat started successfully
if systemctl is-active --quiet tomcat; then
   echo "Tomcat started successfully."
else
   echo "Failed to start Tomcat."
fi
