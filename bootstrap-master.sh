#!/bin/sh

# Run on VM to see if ansible has been installed.

if dpkg -l | grep "ansible" 2> /dev/null
then
    echo "Ansible is installed on the VM"
else    
    echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "# Reconfigure etc/hosts" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "10.0.0.2    aero1.dev.lan  aero1" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "10.0.0.5    aero2.dev.lan  aero2" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "10.0.0.25   aero3.dev.lan  aero3" | sudo tee --append /etc/hosts 2> /dev/null
fi