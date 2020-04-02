# ftp-to-sftp-bridge
Allows you to mount an SFTP connection and share it via FTP.

## Installation
1. Set up an EC2 instance on AWS (I used a medium-sized Ubuntu 18.04 instance with of 16 gb disk space)
2. Set up the security groups to allow incoming TCP connections on port 21, and also on ports 21000-21010
3. SSH to the newly created EC2 instance and install and configure docker and docker-compose
   - Docker: https://docs.docker.com/install/linux/docker-ce/ubuntu/
   - Docker Post-Install: https://docs.docker.com/install/linux/linux-postinstall
   - Docker-compose: https://docs.docker.com/compose/install
4. Use git to clone this repo into your `/home/ubuntu/ftp-to-sftp-bridge` folder
6. Add your SSH keys for connecting to remote SFTP servers to the ".ssh" folder.
7. Run `make full-reset-after-changing-ssh-keys`
8. Copy the ".env.example" file to a file named ".env" and configure the "USERS" variable in it so it has your desired FTP users and passwords.
9. Configure the volume mappings in the "docker-compose.yml" file so that the sshfs plugin knows how to mount the remote SFTP connections as Docker volumes.
10. Run `make up` to start the service
11. Use an FTP client to connect to the IP address of the EC2 instance, using one of your user names and passwords

Note: FTP users are automatically created on docker container startup and are mapped to their appropriate folder
at "/ftp/<username>" inside of the container, so you want to mount each sshfs SFTP volume to the appropriate folder.  

## For More Info and Quick Shortcut Commands:

Read the Makefile.