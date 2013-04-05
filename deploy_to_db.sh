#!/usr/bin/env bash

function ec2_scp {
  scp -o StrictHostKeyChecking=no -i /var/go/infra_lab.pem $1 ubuntu@$2:
}

function ec2_ssh {
  ssh -o StrictHostKeyChecking=no -i /var/go/infra_lab.pem ubuntu@$1 $2
}

function vagrant_scp {
	[ ! -f ~/.ssh/vagrant ] && wget https://raw.github.com/mitchellh/vagrant/master/keys/vagrant;chmod 600 ~/.ssh/vagrant
	scp -o StrictHostKeyChecking=no -i ~/.ssh/vagrant $1 vagrant@$2:
}

function vagrant_ssh {
	[ ! -f ~/.ssh/vagrant ] && wget https://raw.github.com/mitchellh/vagrant/master/keys/vagrant;chmod 600 ~/.ssh/vagrant
    ssh -o StrictHostKeyChecking=no -i ~/.ssh/vagrant vagrant@$1 $2
}

# # EC2
# ec2_scp puppet.tgz db.part2.com
# ec2_ssh db.part2.com "tar zxvf puppet.tgz"
# ec2_ssh db.part2.com "sudo puppet apply --modulepath=modules db.pp"

# Vagrant
vagrant_scp puppet.tgz db
vagrant_ssh db "tar zxvf puppet.tgz"
vagrant_ssh db "sudo puppet apply --modulepath=modules db.pp"