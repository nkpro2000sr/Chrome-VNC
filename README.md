# Chrome-noVNC
Chromium with noVNC on Alpine in Docker image.

## To run Chrome noVNC
`docker run --rm -it -p 5980:5980 nkpro/chrome-novnc`

To give extra args for *x11vnc*, run docker with **startVNC extra-args**  
`docker run --rm -it -p 5980:5980 nkpro/chrome-novnc startVNC -forever`

To change the default *Resolution*, run docker with env **-e RESOLUTION=required-resolution**  
`docker run --rm -it -p 5980:5980 -e RESOLUTION=1280x720x24 nkpro/chrome-novnc`

Connect to http://localhost:5980/vnc.html to access.  

### To run bash command line
`docker run --rm -it nkpro/chrome-novnc bash`

## Make a Portable Chromium Browser with Chrome-noVNC docker image
To start container for first time.  
`docker run --name pcb -it -p 5980:5980 nkpro/chrome-novnc`  

To start container for next time.  
`docker start pcb && docker attach pcb`

### To transfer the container to another host.  
```bash
docker commit pcb pcbi
docker save pcbi -o pcbi.tar

# in another host
docker load -i pcbi.tar pcbi
# for first run
docker run --name pcb -it -p 5980:5980 pcbi
# for next runs
docker start pcb && docker attach pcb
```
> you can change 'pcb' and 'pcbi' with any name for container and image.  
