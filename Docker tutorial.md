# Docker tutorial

https://docker-curriculum.com/

after a fews day unsung docker. almost forget how to use it. it's time to pick it up again.

Records help me keep longer memory.

## Container

simplily regard it as a sandbox environment.

#### how

how to create a container

#### what

what is the relation between container and image in docker?

image 相当于安装系统的iso 文件，container就是安装的系统。

an instance.

-----------

we can use `docker ps -a` to show all the containers created by images.

> Running the `run` command with the `-it` flags attaches us to an interactive tty in the container

each time run a image, a new contaienr is created, so we can simply remove it become unused by `docker rm`.

`docker rm $(docker ps -a -q -f status=exited)` remove all existed container.

### Run a container

Start your container using the docker run command and specify the name of the image we just created:

```shell
$ docker run -dp 3000:3000 getting-started
```

Remember the -d and -p flags? We’re running the new container in “detached” mode (in the background) and creating a mapping between the host’s port 3000 to the container’s port 3000. Without the port mapping, we wouldn’t be able to access the application.

### why

why to run a container with argument `-d`?

run in the background.

### open in terminal

 execute an interactive `bash` shell on the container.

```
$ docker exec -it ubuntu_bash bash
```

This will create a new Bash session in the container `ubuntu_bash`.

https://docs.docker.com/engine/reference/commandline/exec/

### stop & remove

`docker stop <container-id>`

`docker rm <container-id>`

`docker rm -f <container-id>`

> by the way, use (playground online)[https://labs.play-with-docker.com/] to test something!

❓how to enter the running container in backstage. for example, enter into the shell of a running ubuntu container

## Container Image

create a container image by `Dockerfile`

`docker build -t getting-started .`

## Volume

Volumes provide the ability to connect specific filesystem paths of the container back to the host machine. If a directory in the container is mounted, changes in that directory are also seen on the host machine. If we mount that same directory across container restarts, we’d see the same files.

现实中的一个物体被连接到梦境，在梦境对这个物体的改变会影响现实世界的它。

[check the data in volume on MaxOS](https://stackoverflow.com/questions/38532483/where-is-var-lib-docker-on-mac-os-x)

With bind mounts, we control the exact mountpoint on the host. We can use this to persist data, but it’s often used to provide additional data into containers. When working on an application, we can use a bind mount to mount our source code into the container to let it see code changes, respond, and let us see the changes right away.

docker become into a running environment.

### Use bind mounts

use `-v` to declare the mounting target. `--mount` is more verbose.

> It is always created as a directory.

-v source:target to bind directory in host system.

```shell
 docker run -d \
  -it \
  --name devtest \
  -v "$(pwd)"/target:/app \
  nginx:latest
```



:question:after mounting the source files, i want to change the file in container. how to do that?

use command `docker inspect <container name>  ` , find 'Mounts' properties, if the RW is true, it says writing in container is okay, or need to change writing permission of the source directory.

