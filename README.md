# Docker-cifs-client

Use to mount SMB share inside a docker container

## Use

Create an fstab override file 

    nano fstab

Add some smb mount info to it

    //my-remote/share  /mnt/smb cifs user=guest,pass=,_netdev 0 0

Then run container mounting your fstab override file over the containers. Note that privileged mode is required for cifs to work in docker, and you have force a mount -a, as there is no reliable way for docker to do this for us

    docker run -v $(pwd)/fstab:/etc/fstab --privileged  shukriadams/cifs-client:0.0.1 /bin/sh -c "mount -a && ls /mnt/smb"

You can achieve the same thing with docker-compose, in this case the container is kept alive indefinitely

    version: "3.5"
    services:
        cifs-client:
            image: shukriadams/cifs-client:latest
            container_name: cifs-client
            privileged : true
            volumes:
                - ./fstab:/etc/fstab
            command: /bin/sh -c "mount -a && while true ;sleep 5; do continue; done"