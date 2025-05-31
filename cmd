# Create wifi connection
nmcli connection add type wifi con-name UoA-WiFi ssid UoA-WiFi
nmcli connection edit CampusWifi
set 802-1x.eap peap
set 802-1x.phase2-auth mschapv2
set 802-1x.identity yourUsername
set 802-1x.password yourPassword
set wifi-sec.key-mgmt wpa-eap
save
activate


# Rebuild system with flake
sudo nixos-rebuild switch --flake ~/nixos_configuration/
