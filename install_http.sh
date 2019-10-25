#!/bin/bash
sudo yum install httpd -y
echo "Automation for the people" | sudo tee /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd

