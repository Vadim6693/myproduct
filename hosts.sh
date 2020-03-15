#!/bin/bash

cat << EOF
{
	"group1": [ "node1.example.com", "node2.example.com" ], 
	"group2": [ "node3.example.com", "node4.example.com" ],

	"_meta": {
    		"hostvars": {
        		"node1.example.com": {
                		"ansible_ssh_user": "student",
                		"ansible_host":  "172.21.1.11"
          		},
        		"node2.example.com": {
                		"ansible_ssh_user": "student",
                		"ansible_host":  "172.21.1.12"
         		},
        		"node3.example.com": {
                		"ansible_ssh_user": "student",
             			"ansible_host":  "172.21.1.13"
          		},
        		"node4.example.com": {
                		"ansible_ssh_user": "student",
                		"ansible_host":  "172.21.1.14"
         		},
        	}
	}

}

EOF
