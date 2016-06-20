#! /bin/sh

cd

if [ ! -f /usr/sbin/apt-fast ];
then
    echo "Installing apt-fast..."
    # apt-fast
    sudo add-apt-repository --yes ppa:saiarcot895/myppa > /tmp/foo
    sudo apt-get -qq update
    sudo apt-get -qq install --yes apt-fast
    # sudo dpkg-reconfigure apt-fast  # configure
else
    echo "apt-fast is installed."
fi


install_package()
{
    if dpkg -s $1 > /dev/null;
    then
        echo "$1 is installed."
    else
        package=$1
        ppa=$2
        if [ -z $2 ]; then
            sudo add-apt-repository --yes ppa:$ppa > /tmp/foo
        fi
        sudo apt-fast update -qq
        sudo apt-fast -qq --yes install $package
        echo "$package is installed \n\n"
    fi
}


install_package zsh
install_package git

# install byobu
install_package byobu byobu/ppa


git config --global user.name 'chillaranand'
git config --global user.name 'anand21nanda@gmail.com'

git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh || echo "Cloned oh-my-zsh"
git clone https://github.com/ChillarAnand/.custom-zsh.git .custom-zsh || echo "Cloned custom-zsh"

rm .zshrc
ln -s .custom-zsh/zshrc .zshrc
chsh -s /usr/bin/zsh anand


mkdir -p projects/ubuntu
cd projects/ubuntu


git clone https://github.com/ChillarAnand/os.git
cd os

# salt setup
# python salt/start/setup.py

# run scripts
# activate space2ctrl
./space2ctrl.sh

# install packages
install_package unzip
install_package tree
install_package htop

install_package synapse synapse-core/ppa
rm ~/.config/synapse/config.json
ln -s ~/projects/ubuntu/os/config/synapse/config.json ~/.config/synapse/config.json


# dropbox
echo "Installing dropbox"
if [ ! -f ~/.dropbox-dist/dropboxd ]; then
    cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    ~/.dropbox-dist/dropboxd
fi


# chrome
if [ ! -f /usr/local/bin/emacs ]; then
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
    install_package google-chrome-stable
fi


# install emacs
sudo add-apt-repository --yes ppa:ubuntu-elisp/ppa
sudo apt-fast -qq --yes install emacs-snapshot emacs-snapshot-el

# config
cd
git clone https://github.com/chillaranand/.emacs.d.git
