#!/usr/bin/env bash

#prettier
npm config set prefix ~/.local
npm install -g prettier

#black [python]
pip3 install black

#php-cs-fixer
if [ -f ~/.local/bin/php-cs-fixer ]; then
  php ~/.local/bin/php-cs-fixer self-update
else
  #option 1 - from symfony.com
  #wget https://cs.symfony.com/download/php-cs-fixer-v3.phar -O ~/.local/bin/php-cs-fixer
  
  #option 2 - from github.com
  tag=$(curl -s https://api.github.com/repos/FriendsOfPHP/PHP-CS-Fixer/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
  wget "https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/${tag}/php-cs-fixer.phar" -O ~/.local/bin/php-cs-fixer
  chmod u+x ~/.local/bin/php-cs-fixer
fi

#Taskwiki requirements
pip3 install six
pip3 install pynvim
pip3 install tasklib
#temp tasklib fix https://github.com/GothenburgBitFactory/tasklib/pull/98
sed -i 's/^local_zone = tzlocal.get_localzone()/local_zone = pytz.timezone(str(tzlocal.get_localzone()))/g' ~/.local/lib/python3.9/site-packages/tasklib/serializing.py
