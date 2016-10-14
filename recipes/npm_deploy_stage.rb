#
# Cookbook Name:: npm_install
# Recipe:: default
#
# Copyright 2016, goldver
#
# All rights reserved - Do Not Redistribute
#

# downloads nodejs and Npm
execute 'install_nodejs' do
    command 'curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -; sudo apt-get install -y nodejs build-essential'
    user 'deploy'
end

# Npm specific version
npm_ver = "npm@#{node['npm_install']['npm_version']}"

execute 'npm_version' do
    command 'sudo npm i -g' " #{npm_ver}"
    user 'deploy'
    Chef::Log.info("### Your Npm version is: '#{npm_ver}' ###")
end

# installs Npm (taken from nodejs community CB)
nodejs_npm "my_private_modules" do
    path "/var/www/projects/current" # The root path to your project, containing a package.json file
    json true
    user "deploy"
    group "deploy"
end

# builds Npm
execute 'npm_run_build_stage' do
    command 'cd /var/www/projects/current && npm run build-stage'
    user 'deploy'
    group 'deploy'
end

# runs Assets precompile
execute "assets_precompile" do
    command       "bundle exec rake assets:precompile"
    cwd           "/var/www/projects/current"
    user          "deploy"
    group         "deploy"
    environment({'RAILS_ENV' => node['npm_install']['deploy_env']})
    Chef::Log.info("### Your RAILS_ENV: '#{node['npm_install']['deploy_env']}' ###")
end

# restarts an eye service
execute "eye_restart" do
    command       "eye r all"
    user          "deploy"
    group         "deploy"
end
