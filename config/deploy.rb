require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
# you can use `run :local` to run tasks on local machine before of after the deploy scripts
# run(:local){ say 'done' }

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'blog-rails-intro'
set :domain, 'server-ip-or-domain'
set :user, fetch(:application_name)
set :deploy_to, "/home/#{fetch(:user)}/app"
set :repository, 'git@github.com:TimeTravelerFromNow/blog-rails-intro.git'
set :branch, 'main'
# make sure to run EDITOR='code --wait' ./bin/rails credentials:edit --environment=production,
# and add this then close the file to save.
# secret_key_base: yoursupersecretkey
set :production_key, File.read('config/credentials/production.key').strip # remove newline
set :rvm_use_path, '/etc/profile.d/rvm.sh'

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
# set :shared_dirs, fetch(:shared_dirs, []).push('public/assets')
set :shared_files, fetch(:shared_files, []).push('config/credentials/production.key', 'config/database.yml')
set :shared_dirs, fetch(:shared_dirs, []).push('public/packs', 'node_modules', 'storage')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  ruby_version = File.read('.ruby-version').strip
  raise "Couldn't determine Ruby version: Do you have a file .ruby-version in your project root?" if ruby_version.empty?

  invoke :'rvm:use', ruby_version
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do

  in_path(fetch(:shared_path)) do

    command %[mkdir -p config]

    # Create database.yml for Postgres if it doesn't exist
    # this will override config/database.yml and make sure the user is the app name
    path_database_yml = "config/database.yml"
    database_yml = %[production:
      database: #{fetch(:user)}
      adapter: postgresql
      pool: 5
      timeout: 5000]
    command %[test -e #{path_database_yml} || echo "#{database_yml}" > #{path_database_yml}]

    production_key_file = 'config/credentials/production.key'
    command %[test -e #{production_key_file} || echo "#{fetch(:production_key)}" > #{production_key_file}]
    # Remove others-permission for config directory
    command %[chmod -R o-rwx config]
  end
end

desc "Deploys the current version to the server."
task :deploy do
  invoke :'git:ensure_pushed' # makes sure you've pushed to github

  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.

    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    invoke :'deploy:cleanup'
    on :launch do
     # you need to create a server process with the name of the user for this to work
     # command "sudo systemctl restart #{fetch(:user)}"
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
