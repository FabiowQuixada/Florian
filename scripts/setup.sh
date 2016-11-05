# Backup gem
sudo apt-get install libpq-dev
gem install backup
backup dependencies --install net-ssh net-scp mail
backup generate:model --trigger db_backup


# Externals
cp external/isbn.rb vendor/cache/ruby/2.2.0/gems/blabla-0.0.2/lib/generators/
cp external/brdata.rb vendor/cache/ruby/2.2.0/gems/brdata-3.3.0/
cp external/db_backup.rb ~/Backup/models/


# PhantomJS
sudo apt-get install build-essential chrpath libssl-dev libxft-dev
sudo apt-get install libfreetype6 libfreetype6-dev
sudo apt-get install libfontconfig1 libfontconfig1-dev
cd ~
export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
sudo tar xvjf $PHANTOM_JS.tar.bz2
sudo mv $PHANTOM_JS /usr/local/share
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

# Redirects port 3000 to 80
sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000