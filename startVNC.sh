sudo rm -f /tmp/.X${DISPLAY#:}-lock
nohup /usr/bin/Xvfb $DISPLAY -screen 0 $RESOLUTION -ac +extension GLX +render -noreset > /dev/null || true &
while [[ ! $(xdpyinfo -display $DISPLAY 2> /dev/null) ]]; do sleep .3; done
nohup startxfce4 > /dev/null || true &
nohup x11vnc -xkb -noxrecord -noxfixes -noxdamage -display $DISPLAY -rfbauth /home/user/.vnc/passwd -rfbport 5900 "$@" &
echo Press Ctrl-C to exit
if [[ -f $CERT ]]; then
  nohup /home/user/noVNC/utils/launch.sh --vnc localhost:5900 --listen 5980 --cert $CERT
elif [[ -n $CERT ]]; then
  nohup openssl req -new -x509 -days 365 -nodes -out /home/user/self.pem -keyout /home/user/self.pem -subj "/C=IN/ST=TN/L=TN/O=nkpro2000sr/OU=Chrome-VNC/CN=example.com" 
  nohup /home/user/noVNC/utils/launch.sh --vnc localhost:5900 --listen 5980 --cert /home/user/self.pem
else
  nohup /home/user/noVNC/utils/launch.sh --vnc localhost:5900 --listen 5980
fi
