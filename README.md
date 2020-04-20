# Chrome-VNC
Chromium with VNC on Alpine in Docker image.

## To run Chrome VNC
`docker run --rm -it -p 5900:5900 nkpro/chrome-vnc`

To give extra args for *x11vnc*, run docker with **startVNC extra-args**  
`docker run --rm -it -p 5900:5900 nkpro/chrome-vnc startVNC -forever`

To change the default *Resolution*, run docker with env **-e RESOLUTION=required-resolution**  
`docker run --rm -it -p 5900:5900 -e RESOLUTION=1280x720x24 nkpro/chrome-vnc`

### To run bash command line
`docker run --rm -it -p 5900:5900 nkpro/chrome-vnc bash`

## Make a Portable Chromium Browser with Chrome-VNC docker image
...
