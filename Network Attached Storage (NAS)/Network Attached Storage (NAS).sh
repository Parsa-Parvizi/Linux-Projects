#!/bin/bash

# Function to check if Samba is installed
check_samba_installed() {
  dpkg -l | grep samba > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Samba is already installed."
  else
    echo "Samba is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install samba samba-common-bin -y
  fi
}

# Function to configure Samba
configure_samba() {
  sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
  sudo sed -i 's/# workgroup = WORKGROUP/workgroup = WORKGROUP/' /etc/samba/smb.conf 
  sudo sed -i 's/# security = user/security = user/' /etc/samba/smb.conf
  sudo sed -i 's/# guest account = nobody/guest account = nobody/' /etc/samba/smb.conf 
  sudo sed -i 's/# [homes]/[homes]/c\
[homes]' /etc/samba/smb.conf
  sudo sed -i 's/# comment = Home Directories/comment = Home Directories/' /etc/samba/smb.conf
  sudo sed -i 's/# browseable = yes/browseable = yes/' /etc/samba/smb.conf
  sudo sed -i 's/# read only = no/read only = no/' /etc/samba/smb.conf
  sudo sed -i 's/# create mask = 0644/create mask = 0644/' /etc/samba/smb.conf
  sudo sed -i 's/# directory mask = 0755/directory mask = 0755/' /etc/samba/smb.conf
  sudo sed -i 's/# valid users = @users/valid users = @users/' /etc/samba/smb.conf
  sudo systemctl restart smbd
  sudo systemctl enable smbd
}

# Function to create a Samba user
create_samba_user() {
  sudo useradd -m nasuser
  sudo smbpasswd -a nasuser
}

# Main script
check_samba_installed
configure_samba
create_samba_user

echo "NAS setup complete!"
echo "You can now access the shared folders from other devices."