#
# Cookbook Name:: npm_install
# Recipe:: default
#
# Copyright 2016, goldver
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nodejs" # community cookbook of Nodejs

# Sets permission and user for ubuntu default user
directory '/home/ubuntu'  do
    owner 'deploy'
    group 'deploy'
    mode '0777'
end

current_path =  `sudo cat /var/chef/cache/revision-deploys` 
node.run_state['new_path'] = current_path.to_s.split(',').last.split('"').drop(1).first # lookup for the path and splits name of release
Chef::Log.info("### Your Current Directory: '#{node.run_state['new_path']}' ###")

# Installs npm
execute 'install_npm' do
    cwd "#{node.run_state['new_path']}"
    Chef::Log.info("### Your Current Directory: '#{cwd}' ###")
    command 'npm install'
    user 'deploy'
    only_if {File.exist?("#{node.run_state['new_path']}/package.json")}
end

# Builds npm
execute 'build_npm' do
    cwd "#{node.run_state['new_path']}"
    Chef::Log.info("### Your Current Directory: '#{cwd}' ###")
    command 'npm run build'
    user 'deploy'
    only_if {File.exist?("#{node.run_state['new_path']}/package.json")}
end

execute 'install_node_and_npm' do
    command 'wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash && export NVM_DIR="/home/deploy/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && nvm install v6.6.0 && nvm alias default v6.6.0 && cd /var/www/projects/current/ && npm install && npm run build-production'
    user 'deploy'
    group 'deploy'
end