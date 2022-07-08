# x11docker/fvwm
# 
# FVWM window manager in docker
# Petite image based on alpine
#
# Use x11docker to run image. 
# Get x11docker from github: 
#   https://github.com/mviereck/x11docker 
#
# Examples: 
#   Desktop:
#       x11docker --desktop x11docker/fvwm
#   Desktop with init system openrc:
#       x11docker --desktop --openrc x11docker/fvwm
#   Single application (terminal):
#       x11docker x11docker/fvwm xterm
#
# Options:
# Persistent home folder stored on host with   --home
# Shared host file or folder with              --share PATH
# Clipboard sharing with option                --clipboard
# Sound support with option                    --alsa
#
# Look at x11docker --help for further options.

FROM alpine
RUN apk add --no-cache dwm make g++ gcc libx11-dev font-bitstream-type1 sudo openvpn git xterm dbus openrc make libxinerama-dev libxft-dev ncurses sed feh geoip bind tini xsetroot

RUN git clone https://github.com/koahv/dwm-docker.git 
RUN (cd dwm-docker/dwm; make clean install)

COPY time.sh /usr/bin/time.sh

ENTRYPOINT ["/tini", "--", "/usr/bin/time.sh"] 



CMD dwm
