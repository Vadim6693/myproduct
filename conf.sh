#!/bin/bash
for i in {1..6}; do ssh-copy-id node$i; done

for i in {1..6}; do ssh node$i "sudo openssl genrsa -out /tmp/glusterfs.key 2048"; done

for i in {1..6}; do ssh node$i sudo openssl req -new -x509 -key /tmp/glusterfs.key -subj "/CN=$(hostname)" -out /tmp/glusterfs.pem; done

for i in {1..6}; do scp root@node$i:/tmp/glusterfs.pem /tmp/node$i.pem; done

for i in {1..6}; do scp root@node$i:/tmp/glusterfs.key /tmp/node$i.key; done

for i in {1..4}; do ssh node$i "rm -f /tmp/glustefs*"; done

### this file is for all server nodes only ###
cat /tmp/node1.pem /tmp/node2.pem /tmp/node3.pem /tmp/node4.pem /tmp/node5.pem /tmp/node6.pem > /tmp/glusterfs.ca

for i in 5;
do
	yum install -y httpd
	systemctl enable httpd
	systemctl start httpd
	echo "This $(hostname) is used as FTP server and provides glusterfs.pem glusterfs.key glusterfs.ca files" > /var/www/html/index.html
	systemctl restart httpd
done

cp /tmp/node*.key /var/www/html/
cp /tmp/node*.pem /var/www/html/
cp /tmp/glusterfs.ca /var/www/html/