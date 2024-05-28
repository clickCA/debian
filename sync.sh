current_date_time=$(date)

# mkdir dotfiles
# mkdir dotfiles/.config
# cp ~/.zshrc dotfiles
cp ~/.bashrc .
cp ~/Pictures/* ./background
# mkdir dotfiles/.config/kitty && cp ~/.config/kitty/kitty.conf dotfiles/.config/kitty

git add .
git commit -m "config of: $current_date_time"