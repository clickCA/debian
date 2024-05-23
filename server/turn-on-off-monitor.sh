
# To turn off monitor in console, the command is the following: https://askubuntu.com/questions/62858/turn-off-monitor-using-command-line

sudo vbetool dpms off
# To regain control of the console on pressing Enter key, I suggest

sudo sh -c 'vbetool dpms off; read ans; vbetool dpms on'