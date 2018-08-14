# Vagrant self study

1. [Install Vagrant and VirtualBox](#1-install-vagrant-and-virtualbox)
2. [Create a new environment](#2-create-a-new-environment)
3. [Run an environment](#3-run-an-environment)
4. [Modify an environment](#4-modify-an-environment)
5. [Close / Destroy an environment](#5-close--destroy-an-environment)

## 1. Install Vagrant and VirtualBox
Installing Vagrant and VirtualBox are extremely easy.
Head over to the downloads page and get the appropriate installer or package for your platform:
- [Vagrant downloads page](https://www.vagrantup.com/downloads.html)
- [VirtualBox downloads page](https://www.virtualbox.org/wiki/Downloads)

## 2. Create a new environment
#### Init
- Command: `vagrant init [name [url]]`
- This initializes the current directory to be a Vagrant environment by creating an initial Vagrantfile if one does not already exist.
- Reference: [vagrant init](https://www.vagrantup.com/docs/cli/init.html)
### Example 1
See [this video](https://youtu.be/71xNE7Xs6ms) for initial step by step guide.

## 3. Run an environment
#### Up
- Command: `vagrant up [name|id]`
- This command creates and configures guest machines according to your Vagrantfile.
- Reference: [vagrant up](https://www.vagrantup.com/docs/cli/up.html)
#### SSH
- Command: `vagrant ssh [name|id] [-- extra_ssh_args]`
- This will SSH into a running Vagrant machine and give you access to a shell.
- Reference: [vagrant ssh](https://www.vagrantup.com/docs/cli/ssh.html)
### Example 2
A very simple vagrant project to make a web server for Yii application:
- Change working folder to the folder of this repository.
- Run `vagrant up` to create a new environment and setup Apache, PHP, MySQL, Composer. References: [Vagrantfile](Vagrantfile) and [shell-script](setup-as-root.sh).
- After the new environment is ready, run `vagrant ssh` to connect to the virtual machine to continue setting Yii framework.
- Run `sudo composer create-project yiisoft/yii /var/www/html/yii` to install Yii framework into folder `/var/www/html/yii`.
- After installation is done, browse to http://172.20.50.100/yii/requirements/ (this IP is configured in [Vagrantfile](Vagrantfile#L35)), "Yii Requirement Checker" page is shown.

## 4. Modify an environment
#### Provision
- Command: `vagrant provision [vm-name]`
- Runs any configured provisioners against the running Vagrant managed machine.
- Reference: [vagrant provision](https://www.vagrantup.com/docs/cli/provision.html)
#### Reload
- Command: `vagrant reload [name|id]`
- The equivalent of running [a halt](#halt) followed by [an up](#up).
- Reference: [vagrant reload](https://www.vagrantup.com/docs/cli/reload.html)
#### Plugin
- Command: `vagrant plugin`
- This is the command used to manage plugins.
- Reference: [vagrant plugin](https://www.vagrantup.com/docs/cli/plugin.html)
#### Box Update
- Command: `vagrant box update`
- This command updates the box for the current Vagrant environment if there are updates available.
- Reference: [vagrant box](https://www.vagrantup.com/docs/cli/box.html#box-update)
#### Box Prune
- Command: `vagrant box prune`
- This command removes old versions of installed boxes. If the box is currently in use vagrant will ask for confirmation.
- Reference: [vagrant box](https://www.vagrantup.com/docs/cli/box.html#box-prune)
### Example 3
Continue of [Example 2](#example-2):
- Browse to http://172.20.50.100/yii/requirements/, assert that `Mcrypt extension` is "Warning".
- Edit file [setup-as-root.sh](setup-as-root.sh), append:
```bash
apt-get install -y php-mcrypt
systemctl restart apache2
```
- Close/Exit SSH connection if you are connecting.
- Run `vagrant provision`, the virtual machine will re-run provision script and install the missing package (php-mcrypt).
- Browse to http://172.20.50.100/yii/requirements/ again, assert that `Mcrypt extension` is "Passed".

## 5. Close / Destroy an environment
#### Halt
- Command: `vagrant halt [name|id]`
- This command shuts down (turns off) the running machine Vagrant is managing.
- Reference: [vagrant halt](https://www.vagrantup.com/docs/cli/halt.html)
#### Suspend
- Command: `vagrant suspend [name|id]`
- This suspends (hibernates) the guest machine Vagrant is managing, rather than fully [shutting it down](#halt) or [destroying it](#destroy).
- Reference: [vagrant suspend](https://www.vagrantup.com/docs/cli/suspend.html)
#### Resume
- Command: `vagrant resume [name|id]`
- This resumes a Vagrant managed machine that was previously suspended, perhaps with the [suspend command](#suspend).
- Hint: we can still use `vagrant up` to resume a suspended machine.
- Reference: [vagrant resume](https://www.vagrantup.com/docs/cli/resume.html)
#### Destroy
- Command: `vagrant destroy [name|id]`
- This command stops the running machine Vagrant is managing and destroys all resources that were created during the machine creation process.
- Reference: [vagrant destroy](https://www.vagrantup.com/docs/cli/destroy.html)
