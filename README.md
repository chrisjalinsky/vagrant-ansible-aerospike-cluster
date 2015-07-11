Ansible Deploy Aerospike Cluster  
================================

This is an ansible playbook for deploying an Aerospike cluster on Ubuntu 14.04 LTS, using the free community edition. It is configured to use a lot of the defaults, except the mesh mode for networking. The same namespaces are configured by default. In Virtualbox you must allocate a new storage device to use a device namespace.  


The Vagrant VMs are not provisioned using the ansible provisioner. It was created this way to be able to use Ansible manually.  


The default vagrant up will create 3 VMs:  

* aero1  
* aero2  
* aero3  

aero1 is the ansible server, and all 3 vms are configured to be Aerospike nodes.  

Take note of the /etc/ansible/inventory directory. Here you may configure different environments for Ansible. By default there is a production directory that contains host_vars/ and group_vars/ relevant to the configuration of the Aerospike configuration file. Once deployed, this file will be generated at /etc/aerospike/aerospike.conf  

To use a device as a namespace, you have to manually added it to the namespaces in the group_vars/ folder  

To run the Ansible playbook which deploys a 3 node Aerospike cluster in Virtualbox:  
-----------------------------------------------------------------------------------

log in to aero1:
    <code>vagrant ssh aero1</code>  

Run the playbook for the Aerospike cluster:  
    <code>ansible-playbook /etc/ansible/playbooks/deploy_aerospike_cluster.yml -i /etc/ansible/inventory/production -u vagrant -k</code>  


The default SSH password for the vagrant user
    <code>vagrant</code>  
    

Then run the playbook to deploy the Aerospike Monitoring Console on aero1:  
    <code>ansible-playbook /etc/ansible/playbooks/deploy_amc.yml -i /etc/ansible/inventory/production -u vagrant -k</code>  

NOTE: I had to add a route to my host only adapter Virtualbox network to view the AMC console (my device is called vboxnet14):  
    <code>sudo route -nv add -net 10.0.0.1/24 -interface vboxnet14</code>  
