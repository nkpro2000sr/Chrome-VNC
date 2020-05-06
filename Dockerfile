FROM alpine

LABEL maintainer="Naveen S R <srnaveen2k@yahoo.com>"

ENV DISPLAY :52
ENV RESOLUTION 1920x1080x24 

RUN apk add sudo bash xfce4 xvfb xdpyinfo lightdm-gtk-greeter x11vnc xfce4-terminal chromium python git && \
    echo 'CHROMIUM_FLAGS="--disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --no-sandbox"' >> /etc/chromium/chromium.conf && \
    dbus-uuidgen > /var/lib/dbus/machine-id

RUN adduser -h /home/user -s /bin/bash -S -D user && echo "user:passwd" | chpasswd && \
    echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER user
WORKDIR /home/user
RUN mkdir -p /home/user/.vnc && x11vnc -storepasswd passwd /home/user/.vnc/passwd && \
    git clone --depth 1 https://github.com/novnc/noVNC.git /home/user/noVNC && \
    git clone --depth 1 https://github.com/novnc/websockify /home/user/noVNC/utils/websockify && \
    rm -rf /home/user/noVNC/.git && \
    rm -rf /home/user/noVNC/utils/websockify/.git && \
    sed -i -- "s/ps -p/ps -o pid | grep/g" /home/user/noVNC/utils/launch.sh && \
    sudo apk del git

RUN echo 'sudo rm -f /tmp/.X${DISPLAY#:}-lock' > /home/user/startVNC.sh && \
    echo 'nohup /usr/bin/Xvfb $DISPLAY -screen 0 $RESOLUTION -ac +extension GLX +render -noreset > /dev/null || true &' >> /home/user/startVNC.sh && \
    echo 'while [[ ! $(xdpyinfo -display $DISPLAY 2> /dev/null) ]]; do sleep .3; done' >> /home/user/startVNC.sh && \
    echo 'nohup startxfce4 > /dev/null || true &' >> /home/user/startVNC.sh && \
    echo 'nohup x11vnc -xkb -noxrecord -noxfixes -noxdamage -display $DISPLAY -rfbauth /home/user/.vnc/passwd -rfbport 5900 "$@" &' >> /home/user/startVNC.sh && \
    echo 'echo Press Ctrl-C to exit' >> /home/user/startVNC.sh && \
    echo 'nohup /home/user/noVNC/utils/launch.sh --vnc localhost:5900 --listen 5980' >> /home/user/startVNC.sh && \
    chmod +x /home/user/startVNC.sh

ENTRYPOINT ["/bin/bash","-c", "\
            startVNC () { \
                ./startVNC.sh \"$@\"; \
            }; \"$@\"", "foo"]

EXPOSE 5980
CMD ["startVNC"]
