print_figlet() {
    printf "%s\n" \
    " __  __                          __                   __" \
    "/\\ \\/\\ \\                        /\\ \\                 /\\ \\" \
    "\\ \\ \\/'/'  __  __    ___ ___    \\_\\ \\    ___     ___ \\ \\/      ____" \
    " \\ \\ , <  /\\ \\/\\ \\ /' __\` __\`\\  /'_\` \\  / __\`\\ /' _ \`\\\\/      /',__\\" \
    "  \\ \\ \\\\\`\\\\ \\ \\_\\ \\/\\ \\/\\ \\/\\ \\/\\ \\L\\ \\/\\ \\L\\ \\/\\ \\/\\ \\      /\\__, \`\\" \
    "   \\ \\_\\ \\_\\/\`____ \\ \\_\\ \\_\\ \\_\\ \\___,_\\ \\____/\\ \\_\\ \\_\\     \\/\\____/" \
    "    \\/_/\\/_/\`/___/> \\/_/\\/_/\\/_/\\/__,_ /\\/___/  \\/_/\\/_/      \\/___/" \
    "               /\\___/" \
    "               \\/__/" \
    "               __                                    ___" \
    "              /\\ \\                                 /'___\\ __" \
    " ____     ____\\ \\ \\___         ___    ___     ___ /\\ \\__//\\_\\     __" \
    "/\\_ ,\`\\  /',__\\\\ \\  _ \`\\      /'___\\ / __\`\\ /' _ \`\\ \\ ,__\\/\\ \\  /'_ \`\\" \
    "\\/_/  /_/\\__, \`\\\\ \\ \\ \\ \\    /\\ \\__//\\ \\L\\ \\/\\ \\/\\ \\ \\ \\_/\\ \\ \\/\\ \\L\\ \\" \
    "  /\\____\\/\\____/ \\ \\_\\ \\_\\   \\ \\____\\ \\____/\\ \\_\\ \\_\\ \\_\\  \\ \\_\\ \\____ \\" \
    "  \\/____/\\/___/   \\/_/\\/_/    \\/____/\\/___/  \\/_/\\/_/\\/_/   \\/_/\\/___L\\ \\" \
    "                                                                  /\\____/" \
    "                                                                  \\_/__/"
}

print_figlet

echo "=========================="
echo "Downloading .zshrc..."
echo "=========================="
if [ -f ~/.zshrc ];then
    echo "Found existing .zshrc file, backing it up to ~/.zshrc.bak"
    mv ~/.zshrc ~/.zshrc.bak
fi
curl -fsSL https://raw.githubusercontent.com/Kymdon13/ZSH-Config/refs/heads/main/.zshrc -o ~/.zshrc

echo "=========================="
echo "Downloading .p10k.zsh..."
echo "=========================="
if [ -f ~/.p10k.zsh ];then
    echo "Found existing .p10k.zsh file, backing it up to ~/.p10k.zsh.bak"
    mv ~/.p10k.zsh ~/.p10k.zsh.bak
fi
curl -fsSL https://raw.githubusercontent.com/Kymdon13/ZSH-Config/refs/heads/main/.p10k.zsh -o ~/.p10k.zsh

echo "=========================="
echo "Installing oh-my-zsh..."
echo "=========================="
export CHSH=yes
export RUNZSH=no
export KEEP_ZSHRC=yes
if [ ! -d ~/.oh-my-zsh ];then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

echo "=========================="
echo "Installing p10k..."
echo "=========================="
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "=========================="
echo "Installing zsh-autosuggestions plugin..."
echo "=========================="
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "=========================="
echo "Installing zsh-syntax-highlighting plugin..."
echo "=========================="
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
