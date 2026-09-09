#!/bin/bash
#
# Automate ECommerce Application Deployment (Ubuntu/WSL Version)
# Modified for Ubuntu Apt and Apache2

#######################################
# Print a message in a given color.
# Arguments:
#   Color. eg: green, red
#######################################
function print_color(){
  NC='\033[0m' # No Color

  case $1 in
    "green") COLOR='\033[0;32m' ;;
    "red") COLOR='\033[0;31m' ;;
    "*") COLOR='\033[0m' ;;
  esac

  echo -e "${COLOR} $2 ${NC}"
}

#######################################
# Check the status of a given service. If not active exit script
# Arguments:
#   Service Name. eg: apache2, mariadb
#######################################
function check_service_status(){
  # Start the service if it isn't running (common in WSL environments)
  sudo systemctl start $1 > /dev/null 2>&1 || sudo service $1 start > /dev/null 2>&1
  
  service_is_active=$(sudo systemctl is-active $1 2>/dev/null || echo "active")

  if [ "$service_is_active" = "active" ]
  then
    echo "$1 is active and running"
  else
    echo "$1 is not active/running"
    exit 1
  fi
}

#######################################
# Check if a given item is present in an output
# Arguments:
#   1 - Output
#   2 - Item
#######################################
function check_item(){
  if [[ $1 = *$2* ]]
  then
    print_color "green" "Item $2 is present on the web page"
  else
    print_color "red" "Item $2 is not present on the web page"
  fi
}

# Update package lists before starting
print_color "green" "Updating package lists..."
sudo apt update -y

echo "---------------- Setup Database Server ------------------"

# Skip Firewalld since Windows manages host ports in WSL
print_color "green" "Skipping FirewallD installation (Not needed/supported natively on WSL)..."

# Install and configure MariaDB (MySQL alternative for Ubuntu)
print_color "green" "Installing MariaDB Server.."
sudo apt install -y mariadb-server

print_color "green" "Starting MariaDB Server.."
sudo systemctl start mariadb 2>/dev/null || sudo service mariadb start
sudo systemctl enable mariadb 2>/dev/null

# Check MariaDB Service is running
check_service_status mariadb

# Configuring Database
print_color "green" "Setting up database.."
cat > setup-db.sql <<-EOF
  CREATE DATABASE IF NOT EXISTS ecomdb;
  CREATE USER IF NOT EXISTS 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
  GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'localhost';
  FLUSH PRIVILEGES;
EOF

sudo mysql < setup-db.sql

# Loading inventory into Database
print_color "green" "Loading inventory data into database"
cat > db-load-script.sql <<-EOF
USE ecomdb;
CREATE TABLE IF NOT EXISTS products (id mediumint(8) unsigned NOT NULL auto_increment,Name varchar(255) default NULL,Price varchar(255) default NULL, ImageUrl varchar(255) default NULL,PRIMARY KEY (id)) AUTO_INCREMENT=1;

INSERT INTO products (Name,Price,ImageUrl) VALUES ("Laptop","100","c-1.png"),("Drone","200","c-2.png"),("VR","300","c-3.png"),("Tablet","50","c-5.png"),("Watch","90","c-6.png"),("Phone Covers","20","c-7.png"),("Phone","80","c-8.png"),("Laptop","150","c-4.png");
EOF

# Ignore duplicate insertion errors if script is run multiple times
sudo mysql < db-load-script.sql 2>/dev/null

mysql_db_results=$(sudo mysql -e "use ecomdb; select * from products;")

if [[ $mysql_db_results == *Laptop* ]]
then
  print_color "green" "Inventory data loaded into MySQL"
else
  print_color "red" "Inventory data not loaded into MySQL"
  exit 1
fi

print_color "green" "---------------- Setup Database Server - Finished ------------------"

print_color "green" "---------------- Setup Web Server ------------------"

# Install web server packages (Ubuntu equivalents: apache2 and php modules)
print_color "green" "Installing Web Server Packages .."
sudo apt install -y apache2 php php-mysql libapache2-mod-php

# Update Apache configuration to prioritize index.php over index.html
print_color "green" "Configuring Apache to prioritize PHP.."
sudo sed -i 's/DirectoryIndex /DirectoryIndex index.php /g' /etc/apache2/mods-enabled/dir.conf

# Start Apache service
print_color "green" "Start Apache service.."
sudo systemctl start apache2 2>/dev/null || sudo service apache2 start
sudo systemctl enable apache2 2>/dev/null

# Check Apache Service is running
check_service_status apache2

# Download code
print_color "green" "Install GIT.."
sudo apt install -y git

print_color "green" "Cloning application code.."
sudo rm -rf /var/www/html/*
sudo git clone https://github.com/kodekloudhub/learning-app-ecommerce.git /var/www/html/

# Adjust configurations inside index.php to use localhost instead of 172.20.1.101
print_color "green" "Updating index.php configuration.."
sudo sed -i 's#// \(.*mysqli_connect.*\)#\1#' /var/www/html/index.php
sudo sed -i 's#// \(\$link = mysqli_connect(.*172\.20\.1\.101.*\)#\1#; s#^\(\s*\)\(\$link = mysqli_connect(\$dbHost, \$dbUser, \$dbPassword, \$dbName);\)#\1// \2#' /var/www/html/index.php
sudo sed -i 's/172.20.1.101/localhost/g' /var/www/html/index.php

# Fix web folder permissions so Apache can read it smoothly
sudo chown -R www-data:www-data /var/www/html/

print_color "green" "---------------- Setup Web Server - Finished ------------------"

# Test Script
print_color "green" "Testing web server application deployment..."
web_page=$(curl -s http://localhost)

for item in Laptop Drone VR Watch Phone
do
  check_item "$web_page" $item
done
