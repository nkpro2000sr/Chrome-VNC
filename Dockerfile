FROM alpine

LABEL maintainer="Naveen S R <srnaveen2k@yahoo.com>"

ENV DISPLAY :52
ENV RESOLUTION 1920x1080x24 

RUN apk add sudo bash xfce4 xvfb x11vnc xfce4-terminal chromium && \
    adduser -h /home/user -s /bin/bash -S -D user && echo "user:passwd" | chpasswd && \
    echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER user
WORKDIR /home/user

RUN mkdir -p /home/user/.vnc && x11vnc -storepasswd passwd /home/user/.vnc/passwd && \
    echo 'nohup /usr/bin/Xvfb :52 -screen 0 $RESOLUTION -ac +extension GLX +render -noreset > /dev/null 2>&1 &' > /home/user/startVNC.sh && \
    echo 'nohup startxfce4 > /dev/null 2>&1 &' >> /home/user/startVNC.sh && \
    echo 'nohup x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :52 -rfbauth /home/user/.vnc/passwd -rfbport 5900 "$@"' >> /home/user/startVNC.sh && \
    chmod +x /home/user/startVNC.sh

ENTRYPOINT ["/bin/bash","-c", "\
            startVNC () { \
                nohup /usr/bin/Xvfb :52 -screen 0 $RESOLUTION -ac +extension GLX +render -noreset > /dev/null 2>&1 & \
                nohup startxfce4 > /dev/null 2>&1 & \
                nohup x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :52 -rfbauth /home/user/.vnc/passwd -rfbport 5900 \"$@\"; \
            }; \"$@\"", "foo"]

EXPOSE 5900
CMD ["startVNC"]
