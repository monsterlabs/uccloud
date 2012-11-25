set :hostname, 'uccld.com'
server "#{hostname}", :app, :web, :db, :primary => true

set :branch, "#{ENV['branch'] || 'master'}"
set :rails_env, "production"
set :deploy_to, "/home/#{user}/rails_app/uccld"
