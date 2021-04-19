# Chrome-VNC
Chromium with VNC on Alpine in Docker image.

> username : user (user added to sudoers)  
> password : passwd  
> vnc password : passwd  

## To run Chrome VNC
`docker run --rm -it -p 5900:5900 nkpro/chrome-vnc`

To give extra args for *x11vnc*, run docker with **startVNC extra-args**  
`docker run --rm -it -p 5900:5900 nkpro/chrome-vnc startVNC -forever`

To change the default *Resolution*, run docker with env **-e RESOLUTION=required-resolution**  
`docker run --rm -it -p 5900:5900 -e RESOLUTION=1280x720x24 nkpro/chrome-vnc`

### To run bash command line
`docker run --rm -it nkpro/chrome-vnc bash`

## Make a Portable Chromium Browser with Chrome-VNC docker image
To start container for first time.  
`docker run --name pcb -it -p 5900:5900 nkpro/chrome-vnc`  

To start container for next time.  
`docker start pcb && docker attach pcb`

### To transfer the container to another host.  
```bash
docker commit pcb pcbi
docker save pcbi -o pcbi.tar

# in another host
docker load -i pcbi.tar pcbi
# for first run
docker run --name pcb -it -p 5900:5900 pcbi
# for next runs
docker start pcb && docker attach pcb
```
> you can change 'pcb' and 'pcbi' with any name for container and image.  
