echo "hi there , you should install your THM file"
echo "use this link to install it https://tryhackme.com/r/access"
echo "______________________________________________"

#warpconnection
function warp_connection () {
echo "warp connection... "
curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ buster main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list

sudo apt update && sudo apt install cloudflare-warp

warp-svc register&
warp-cli register
warp-cli connect
}

#checkip
function check_ip_assigned() {
    ip_address=$(curl -s https://ipinfo.io/ip)
    if [[ -n $ip_address ]]; then
        echo "IP address assigned: $ip_address"
        return 0
    else
        echo "IP address not assigned yet."
        return 1
    fi
}

#openvpn
function connect_openvpn() {
echo "connect to open vpn .."
echo " please enter the path of the directory that you downloded the file in "
read path
echo "please inter the file name " 
read name 
cd $path
sudo openvpn $name 
}

#check_connection
function check_connection() {
    ip_to_ping="10.10.10.10"
    echo "Pinging $ip_to_ping..."
    ping -c 3 $ip_to_ping
}

# Function to disconnect from Warp
function disconnect_warp() {
	warp-cli disconnect
    echo "Disconnecting from Warp..."
}

warp_connection
while ! check_ip_assigned; do sleep 5 done
connect_openvpn
check_connection
disconnect_warp 
echo "process completed ;) "
