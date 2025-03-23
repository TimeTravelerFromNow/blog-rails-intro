This README is for describing server configuration files.
It includes step by step guides of how to create configuration files and how to use them.
This step of the VPS deploy process is difficult because there is lots of manual configuration,
permissions need to be set, following the directory structure, as well as specifying the correct app name is important.
Unicorn is the ruby webserver, which needs to be configured as a linux system process.
Nginx is a reverse proxy which routes web traffic through the Unicorn webserver.


Huge credit to Ralf Ebert for his ruby on rails VPS deploy tutorial[1]

* Unicorn setup

Here's an example unicorn configuration which should be placed in the server's rails app user at
~/app/shared/config/unicorn.conf.rb
```
# Get the directory of the app
app_path = File.expand_path(File.join(File.dirname(__FILE__), '../../'))

listen '127.0.0.1:4000'
listen File.join(app_path, 'shared/unicorn.sock'), :backlog => 64

worker_processes 2

working_directory File.join(app_path, 'current')
pid File.join(app_path, 'shared/unicorn.pid')
stderr_path File.join(app_path, 'current/log/unicorn.log')
stdout_path File.join(app_path, 'current/log/unicorn.log')

```

Unicorn as a systemd service, create this at /etc/systemd/system/blog-rails-intro.service
```
[Unit]
Description=blog-rails-intro service
After=network.target

[Service]
Type=forking
WorkingDirectory=/home/blog-rails-intro/app/
User=blog-rails-intro
ExecStart=/usr/local/rvm/bin/rvm in /home/blog-rails-intro/app/current/ do bundle exec unicorn -D -c /home/blog-rails-intro/app/shared/config/unicorn.conf.rb
SyslogIdenitifier=unicorn-blog-rails-intro
#stop by sending only the main process a SIGQUIT signal
KillMode=process
KillSignal=SIGQUIT
#enable reload Unicorn via HUP signal
ExecReload=/bin/kill -HUP $MAINPID
# Try restart of service after 1 second
Restart=always
RestartSec=1
#Path to PID file
PIDFile=/home/blog-rails-intro/app/shared/unicorn.pid

[Install]
WantedBy=multi-user.target
```
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
Then set up nginx...

# Credits
## Ralf Ebert [website](https://ralfebert.com) [github](https://github.com/ralfebert)
