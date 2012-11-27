require "bundler/capistrano"

set :stages, %w{uccld}
set :application, "uccld"
set :default_stage, "uccld"
set :rvm_ruby_string, '1.9.3-p194@uccld'
set :rvm_type, :user
require 'rvm/capistrano'
require 'capistrano/ext/multistage'

ssh_options[:forward_agent] = true
set :bundle_cmd, 'source $HOME/.bash_profile && bundle'
set :user, "ec2-user"
set :use_sudo, false

# SCM config
set :scm, :git
set :repository, "git@github.com:monsterlabs/uccloud.git"
set :branch, "#{ENV['branch'] || 'master'}"

# Deploy config
set :rails_env,  "production"
set :deploy_via, :copy
set :copy_cache, true
set :copy_compression, :gzip
set :copy_exclude, [".git/*"]
set :keep_releases, 5

# Callbacks after deploy:setup
before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

# Callbacks after deploy:restart
#after "bundle:install", "deploy:migrate"
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  desc "Start passenger"
  task :start do
    run "source $HOME/.bash_profile && cd #{deploy_to}/current && rake passenger:start"
  end
  desc "Stop passenger"
  task :stop do
    run "source $HOME/.bash_profile && cd #{deploy_to}/current && rake passenger:stop"
  end
  desc "Restart passenger"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "source $HOME/.bash_profile && cd #{deploy_to}/current && rake passenger:restart"
  end
end
