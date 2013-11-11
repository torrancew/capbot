require 'safe_yaml'

cfg = YAML.load_file('config/deploy.yml', :safe => true)
cfg['servers'].each{ |host, data| server host, data }

set :application, 'capbot'
set :repo_url,    "git://github.com/torrancew/#{fetch(:application)}.git"

# rbenv Settings
set :rbenv_type,        :system
set :rbenv_ruby,        'jruby-1.7.6'
set :rbenv_custom_path, '/usr/local/share/rbenv'

# Bundler Settings
set :bundle_roles, %w{app}

set :scm,       :git
set :deploy_to, "/usr/local/share/deploy/#{fetch(:application)}"

set :pty,       false
set :format,    :pretty
set :log_level, :info

set :linked_files, %w{.env}
set :linked_dirs,  %w{bin log tmp}

set :keep_releases, 5

namespace :deploy do
  after :finishing, 'deploy:cleanup'
end

