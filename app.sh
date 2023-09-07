#!/bin/bash

# Function to check if a package is installed
is_package_installed() {
  local package_name="$1"
  if command -v "$package_name" &>/dev/null; then
    return 0 # Package is installed
  else
    return 1 # Package is not installed
  fi
}

# Install common packages
install_common_packages() {
  sudo yum update -y
  sudo yum install -y wget unzip
}

# Install Apache and set up a simple web application
install_apache() {
  if is_package_installed "httpd"; then
    echo "Apache is already installed."
  else
    sudo yum install -y httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
  fi
  
  # Create web content
  echo '<h1>Hello MANOJKUMAR MOVVA, Your New APP Ready</h1>' | sudo tee /var/www/html/index.html
  sudo mkdir /var/www/html/app1
  echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>OneMuthoot - APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
}

# Main script execution
if [[ -f /etc/redhat-release ]]; then
  install_common_packages
  install_apache
elif [[ -f /etc/lsb-release ]]; then
  install_common_packages
  install_apache
elif [[ -f /etc/system-release && $(cat /etc/system-release) == *"Amazon Linux"* ]]; then
  install_common_packages
  install_apache
else
  echo "Unsupported operating system."
  exit 1
fi
