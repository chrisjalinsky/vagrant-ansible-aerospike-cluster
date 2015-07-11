Ansible Deploy Aerospike Cluster  
================================

This is an ansible playbook for deploying an Aerospike cluster on Ubuntu 14.04 LTS, using the free community edition. It is configured to use most defaults, except the mesh mode for networking. The same namespaces are configured by default. In Virtualbox you must allocate a new storage device to each VM if you plan to use a device namespace.   


The Vagrant VMs are not provisioned using the ansible provisioner. It was created this way to be able to use Ansible manually, mostly to understand the Ansible install procedure using apt. These steps can be seen in the bootstrap-ansible.sh script.   


The default vagrant up will create 3 VMs:  

* aero1  
* aero2  
* aero3  

aero1 is configured in the inventory group to be the ansible server, and all 3 vms are configured to be Aerospike nodes.  

Take note of the /etc/ansible/inventory directory. Here you can configure different environments for Ansible. By default there is a production directory that contains host_vars/ and group_vars/ relevant to the creation of the Aerospike configuration file. It is a Jinja2 template found in the roles directory. As Aerospike is deployed via Ansible, this file will be generated at /etc/aerospike/aerospike.conf  

To use a new device as a namespace, you have to manually added it to the namespaces in the group_vars/ folder. This device needs to be unused and partition free. In Virtualbox, while the VMs are powered down, you can add additional devices to each VM. Click Settings -> Storage -> + (for new device) -> add hard drive -> you can choose the defaults for hard drive.  

To run the Ansible playbook which deploys a 3 node Aerospike cluster in Virtualbox:  
-----------------------------------------------------------------------------------

log in to aero1:
    <pre><code>vagrant ssh aero1</code></pre>  

Run the playbook for the Aerospike cluster:  
    <pre><code>ansible-playbook /etc/ansible/playbooks/deploy_aerospike_cluster.yml -i /etc/ansible/inventory/production -u vagrant -k</code></pre>  


The default SSH password for the vagrant user
    <pre><code>vagrant</code></pre>  
    

Then run the playbook to deploy the Aerospike Monitoring Console on aero1:  
    <pre><code>ansible-playbook /etc/ansible/playbooks/deploy_amc.yml -i /etc/ansible/inventory/production -u vagrant -k</code></pre>  

NOTE: I had to add a route to my host only adapter Virtualbox network to view the AMC console (my device is called vboxnet14):  
    <pre><code>sudo route -nv add -net 10.0.0.1/24 -interface vboxnet14</code></pre>  


The bootstrap files provision the VMs with basic networking. Routing needs to be configured in Vagrant/Virtualbox to allow the host only adapters to communicate with one another. The next steps will be to allow DHCP to control the networking aspect of this project.  

Being new to both Ansible and Aerospike, any help, ideas or feedback would be appreciated and considered.  
