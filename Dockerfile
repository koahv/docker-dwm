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

#ENV http_proxy http://127.0.0.1:8118
#ENV https_proxy https://127.0.0.1:8118


RUN apk update && apk upgrade && apk add --no-cache dwm make g++ gcc libx11-dev terminus-font font-bitstream-type1 sudo openvpn tor git xterm dbus openrc make libxinerama-dev libxft-dev ncurses sed feh bind tini xsetroot feh jq gvim firefox-esr

#COPY time.sh /usr/bin/time.sh

RUN git clone https://github.com/koahv/docker-dwm.git
RUN git clone https://github.com/koahv/st.git

RUN (cd docker-dwm/dwm; make clean install)
RUN (cd docker-dwm/session; install -m0755 -D dwm-custom /usr/bin/dwm-custom)
RUN (cd docker-dwm/config/dmenu-status; install -m0755 -D time /usr/bin/time)
RUN (cd docker-dwm/config; install -m0755 -D geo /usr/bin/geo)
RUN (cd st; make clean install)

RUN (cd docker-dwm/config/bg; install -m0755 -D alpinelinux-logo_bg.png /usr/local/share/docker-dwm/bg.png;)


#COPY time.sh /usr/bin/time.sh

#ENTRYPOINT ["/tini", "--", "/usr/bin/time.sh"] 



CMD dwm-custom
