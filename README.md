# docker-dwm

alpine with dwm and openvpn container

## Requirements

* [https://github.com/mviereck/x11docker](x11docker) with image x11docker/xserver built
    `x11docker --build x11docker/xserver`

## Instalation

* clone this repository and cd into directory
* build from Dockerfile

    `sudo docker build -t koahv/alpine_dwm:0.6 ./`

* clone [https://github.com/5andr0/openvpn-client](openvpn-client) and cd into directory
* build from Dockerfile
    
    `sudo docker build -t 5andr0/openvpn-client:latest ./`

* create a directory "vpn" in your home folder, and place *.ovpn renamed to vpn.conf there

* modify vpn.conf to include
    
    `auth-user-pass pass`

* create file "pass" and edit to contain vpn client user and password
    
    `vpnuser`
    `vpnpassword`

* start openvpn-client
    
    `sudo docker run -it --cap-add=NET_ADMIN --device /dev/net/tun --name vpn  -v  ~/vpn:/vpn -d 5andr0/openvpn-client:latest`

* start alpine-dwm
    
    `sudo x11docker --desktop koahv/alpine_dwm:0.6 --sudouser --dbus --home --share ~/Public --clipboard --xtest -m --net=container:vpn`

## Troubleshooting

`sudo docker restart vpn`
