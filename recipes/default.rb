#
# Cookbook Name:: npm_install
# Recipe:: default
#
# Copyright 2016, goldver
#
# All rights reserved - Do Not Redistribute
#

if node['npm_install']['deploy_env'] == 'stage'
    include_recipe "#{cookbook_name}::npm_deploy_stage"
elsif node['npm_install']['deploy_env'] == 'production'
    include_recipe "#{cookbook_name}::npm_deploy_prod"
end

Chef::Log.info("### Your environment: '#{node['npm_install']['deploy_env']}' ###")






