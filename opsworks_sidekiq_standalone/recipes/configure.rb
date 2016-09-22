# Adapted from rails::configure: https://github.com/aws/opsworks-cookbooks/blob/master/rails/recipes/configure.rb

include_recipe "deploy"
include_recipe "opsworks_sidekiq_standalone::service"

# Craft needs this module -.-
command 'php5enmod mcrypt'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  template "#{deploy[:deploy_to]}/shared/config/memcached.yml" do
    source "memcached.yml.erb"
    cookbook 'rails'
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables(
      :memcached => deploy[:memcached] || {},
      :environment => deploy[:rails_env]
    )

    only_if do
      File.exists?(deploy[:deploy_to]) && File.exists?("#{deploy[:deploy_to]}/shared/config/")
    end
  end
end
