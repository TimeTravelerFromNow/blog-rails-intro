This README is for describing server configuration files.
It includes step by step guides of how to create configuration files and how to use them.
This step of the VPS deploy process is difficult because there is lots of manual configuration,
permissions need to be set, following the directory structure, as well as specifying the correct app name is important.
Unicorn is the ruby webserver, which needs to be configured as a linux system process.
Nginx is a reverse proxy which routes web traffic through the Unicorn webserver.

## Unicorn setup

### Unicorn config

Here's an example unicorn configuration which should be placed in the server's rails app shared config directory

`curl https://raw.githubusercontent.com/timetravelerfromnow/blog-rails-intro/refs/heads/main/example_configs/unicorn.conf.rb > ~/app/shared/config/unicorn.conf.rb`

### Unicorn system service

Unicorn as a systemd service, create this in your server, rename to the app name.

`curl https://raw.githubusercontent.com/timetravelerfromnow/blog-rails-intro/refs/heads/main/example_configs/unicorn.service > /etc/systemd/system/blog-rails-intro.service`

Manually replace `blog-rails-intro` with your app name
Double check `ExecStart=/usr/share/rvm/bin/rvm` is set to your ruby version manager's executable. You can check the executable path in the server with `which rvm` or `which rbenv`

Then test the process starts and stops:
`systemctl daemon-reload`
`systemctl start blog-rails-intro`
`systemctl stop blog-rails-intro`
`systemctl restart blog-rails-intro`
Enable on boot
`systemctl enable blog-rails-intro`

### Give permissions to restart the service

As root,
`EDITOR=nano visudo` (sudoers file gives sudo access)
`blog-rails-live ALL=(ALL) NOPASSWD: /bin/systemctl restart blog-rails-live`
Save the file, now the rails app user can restart the unicorn service, uncomment the deploy.rb config line that restarts the service

### Unicorn rack 3 incompatibility

with Rails version >7.1 which uses Rack 3, unicorn may fail and error (check your logs shared/logs). Follow similar steps as above to switch your ruby webserver to `puma` or manually add support by monkeypatching
`/home/blog-rails-intro/app/current/vendor/bundle/ruby/3.3.0/gems/unicorn-6.1.0/lib/unicorn/http_response.rb`
Wont go into detail on this issue

## Nginx

Create a nginx sites-available file named the same as your rails app

`curl https://raw.githubusercontent.com/timetravelerfromnow/blog-rails-intro/refs/heads/main/example_configs/nginx-rails-site > /etc/nginx/sites-available/blog-rails-intro`

Edit it to use your app name. Then obtain a domain, set DNS records to your server ip. Edit the nginx file to use your domain instead of `example.com`,
then symbol link it to sites enabled like so.

`ln -s /etc/nginx/sites-available/blog-rails-intro /etc/nginx/sites-enabled/blog-rails-intro`
`systemctl reload nginx`

Give the root user permissions to read /home/blog-rails-live so nginx can read unicorn.sock and assets

`chmod 755 /home/blog-rails-intro`

## rbenv

if you decide to use rbenv, before installing ruby set rbenv root to a shared folder

`export RBENV_ROOT="/opt/rbenv"`

so it only needs installing once per user on your server, then create a linux user group (wont detail this here, you can look it up).
give recursive read/write/exec permissions to the group for the shared `/opt/rbenv` dir, then add all rails apps users to group.
This gives your rails user permissions to update gems.

Then the process for config/deploy.rb mina deploy config file:

```
# top of file
require 'mina/rbenv'
set :rbenv_path, '/opt/rbenv'
# in task(:remove_environment)
invoke 'rbenv:load' # instead of rvm use
```
rbenv should automatically read the .ruby-version file and select the correct ruby version, which is nice

## Shared storage/ folder

if you want to backup storage by version, first remove 'storage' from shared directories declaration.
Then add a command like `%[cp -r ~/app/current/storage .]`

The benefit of this approach is you can manually handle the storage, and during rollbacks you can retrieve older storage if the current one is buggy.
The drawback is that it will take up more space.

## Credits
1. Ralf Ebert [website](https://ralfebert.com) [github](https://github.com/ralfebert)
