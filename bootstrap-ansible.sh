#!/bin/sh

# Run on VM to see if ansible has been installed.

if dpkg -l | grep "ansible" 2> /dev/null
then
    echo "Ansible is installed on the VM"
else
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install -y ansible
    
    echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "# Reconfigure etc/hosts" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "10.0.0.2    aero1.dev.lan  aero1" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "10.0.0.5    aero2.dev.lan  aero2" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "10.0.0.100  aero3.dev.lan  aero3" | sudo tee --append /etc/hosts 2> /dev/null
    
    ln -s /vagrant/etc/ansible/inventory /etc/ansible/inventory
    ln -s /vagrant/etc/ansible/playbooks /etc/ansible/playbooks
    ln -s /vagrant/etc/ansible/roles /etc/ansible/roles
    
    sudo rm /etc/ansible/ansible.cfg
    ln -s /vagrant/etc/ansible/ansible.cfg /etc/ansible/ansible.cfg

fi