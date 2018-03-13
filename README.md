# vagrant-redis

Vagrant setup for the latest stable version of Redis on an Ubuntu Xenial instance. Providers are available for both VirtualBox and Hyper-V, as this is intended to accomodate quick setup of Redis on a Windows developer machine.  Since Docker/Kubernetes appear to prefer first-hand virtualization, Hyper-V on Windows, it seemed a good course to maintain existing development support for Redis on other projects. 

## Hyper-V Setup

There are a batch file and PowerShell script to manage setup of Hyper-V and forwarding of the default Redis port 6379 to the matching localhost port. Since Vagrant cannot currently configure Hyper-V networking, you must choose the switch manually after running the batch file.