/testing/guestbin/swan-prep
cp policies/* /etc/ipsec.d/policies/
echo "192.1.3.0/24"  >> /etc/ipsec.d/policies/private-or-clear
echo "0.0.0.0/0"  >> /etc/ipsec.d/policies/clear
ipsec setup start
/testing/pluto/bin/wait-until-pluto-started
# give OE policies time to load
sleep 5
echo "initdone"
