source .env
NGROK_AUTHTOKEN=$(cat /home/click/.config/ngrok/ngrok.yml | grep authtoken | cut -d ' ' -f 2)
sudo docker run --restart unless-stopped -it -e NGROK_AUTHTOKEN=$NGROK_AUTHTOKEN ngrok/ngrok:latest http $IMMICH_IP

#  if want static domain add this: --domain=<___.ngrok-free.app>