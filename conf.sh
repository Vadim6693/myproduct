#!/bin/bash

#set ssh-key for hosts
for i in {1..6}; do ssh-copy-id -o StrictHostKeyChecking=no node$i; done

#generate .key and *pem files for servers only
for i in 1 2 3 4 6; do ssh node$i "sudo openssl genrsa -out /tmp/node${i}.key 2048"; done
for i in 1 2 3 4 6; do ssh node$i sudo openssl req -new -x509 -key /tmp/node$i.key -subj "/CN=$(hostname)" -out /tmp/node$i.pem; done

#generate .key and *pem files for client only
sudo openssl genrsa -out /tmp/client.key 2048
sudo openssl req -new -x509 -key /tmp/client.key -subj "/CN=$(hostname)" -out /tmp/client.pem

#create CA file

scp root@node1:/tmp/node1.pem /tmp/
scp root@node1:/tmp/node1.key /tmp/

scp root@node2:/tmp/node2.pem /tmp/
scp root@node2:/tmp/node2.key /tmp/

scp root@node3:/tmp/node3.pem /tmp/
scp root@node3:/tmp/node3.key /tmp/

scp root@node4:/tmp/node4.pem /tmp/
scp root@node4:/tmp/node4.key /tmp/

scp root@node6:/tmp/node6.pem /tmp/
scp root@node6:/tmp/node6.key /tmp/

#for servers
cat /tmp/node1.pem /tmp/node2.pem /tmp/node3.pem /tmp/node4.pem /tmp/node6.pem /tmp/client.pem > /tmp/glusterfs-servers.ca

#for client
cat /tmp/node1.pem /tmp/node2.pem /tmp/node3.pem /tmp/node4.pem /tmp/node6.pem > /tmp/glusterfs-client.ca

#copy to /var/www/html for downloading
for i in 5;
do
	yum install -y httpd
	yum remove glusterfs* -y
	systemctl enable httpd
	systemctl start httpd
	echo "This $(hostname) is used as FTP server and provides glusterfs.pem glusterfs.key glusterfs.ca files" > /var/www/html/index.html
	systemctl restart httpd
done

cp /tmp/*.key /var/www/html/
cp /tmp/*.pem /var/www/html/
cp /tmp/*.ca /var/www/html/
