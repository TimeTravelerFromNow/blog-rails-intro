This README is for describing server configuration files.
It includes step by step guides of how to create configuration files and how to use them.
This step of the VPS deploy process is difficult because there is lots of manual configuration,
permissions need to be set, following the directory structure, as well as specifying the correct app name is important.
Unicorn is the ruby webserver, which needs to be configured as a linux system process.
Nginx is a reverse proxy which routes web traffic through the Unicorn webserver.

## Unicorn setup

Here's an example unicorn configuration which should be placed in the server's rails app user at
~/app/shared/config/unicorn.conf.rb

../unicorn.conf.rb

Unicorn as a systemd service, create this at /etc/systemd/system/blog-rails-intro.service

../unicorn.service

systemd services dont allow variables, so edit as needed (replace blog-rails-intro with your app's name).
Dont try achieving this with variables.
Then test the process starts and stops:
`APP_NAME=blog-rails-intro`
`systemctl daemon-reload`
`systemctl start $APP_NAME`
`systemctl stop $APP_NAME`
`systemctl restart $APP_NAME`
Enable on boot
`systemctl enable $APP_NAME`

## Nginx

copy nginx-rails-site into the server at /etc/nginx/sites-available/blog-rails-intro
then symbol link it to sites enabled like so

`ln -s /etc/nginx/sites-available/blog-rails-intro /etc/nginx/sites-enabled/blog-rails-intro`

If you need to delete it, delete the symbol linked enable file then delete the file in `/etc/nginx/sites-available`

## rbenv

if you decide to use rbenv, before installing ruby set rbenv root to a shared folder

`export RBENV_ROOT="/opt/rbenv"`

so it only needs installing once per user on your server, then create a linux user group
give recursive write permissions to the group for the shared dir, then add all users to group

in the config/deploy.rb mina deploy config file:

```
# top of file
require 'mina/rbenv'
set :rbenv_path, '/opt/rbenv'
# in task(:remove_environment)
invoke 'rbenv:load' # instead of rvm use
```
and rbenv should automatically read the .ruby-version file and select the correct ruby version, which is nice

## Shared storage/ folder
if you want to backup storage by version, first remove 'storage' from shared directories declaration.
Then add a command like %[cp -r ~/app/current/storage .] in the deploy config to copy into ~/app/current/storage from the previous, into the build directory for the next release

The benefit of this approach is you can manually handle the storage, and during rollbacks you can retrieve older storage if the current one is buggy.

## Credits
1. Ralf Ebert [website](https://ralfebert.com) [github](https://github.com/ralfebert)
