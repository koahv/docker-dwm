# docker-dwm

alpine with dwm and openvpn container

## Requirements

* [mviereck/x11docker](https://github.com/mviereck/x11docker) with image x11docker/xserver built
   
   `x11docker --build x11docker/xserver`

## Instalation

* clone this repository and cd into directory
* build from Dockerfile

    `sudo docker build -t koahv/alpine_dwm:0.6 ./`

* clone [5andr0/openvpn-client](https://github.com/5andr0/openvpn-client) and cd into directory
* build from Dockerfile
    
    `sudo docker build -t 5andr0/openvpn-client:latest ./`

* create a directory "vpn" in your home folder, and place *.ovpn renamed to vpn.conf there

* modify vpn.conf to include
    
    `auth-user-pass pass`

* create file "pass" and edit to contain vpn client user and password

    ```
    vpnuser
    vpnpass
    ```

* start openvpn-client
    
    `sudo docker run -it --cap-add=NET_ADMIN --device /dev/net/tun --name vpn  -v  ~/vpn:/vpn -d -f 5andr0/openvpn-client:latest`

* start alpine-dwm (add -f for fullscreen)
    
    `sudo x11docker --desktop koahv/alpine_dwm:0.6 --sudouser --dbus --home --share ~/Public --clipboard --xtest -m --net=container:vpn`

## Troubleshooting

check vpn logs

`sudo docker logs vpn`

restart vpn container

`sudo docker restart vpn`



Ctrl+Shift toggles mouse/kb focus
