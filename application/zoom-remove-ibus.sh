# Due to the annoying ibus dependency, we need to use the following command to remove it from zoom
# Official zoom installation guide: https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0063458#h_adcc0b66-b2f4-468b-bc7a-12c182f354b7
# Patching zoom_amd64.deb to remove ibus dependency
#  https://gist.github.com/zxchris/2536b673a0e24dcce65f09b7dd2db726
S=$(mktemp -d)
dpkg -x zoom_amd64.deb $S
dpkg -e zoom_amd64.deb $S/DEBIAN
sed -i -E 's/(ibus, |, ibus)//' $S/DEBIAN/control
dpkg -b $S zoom_amd64-no-ibus.deb
