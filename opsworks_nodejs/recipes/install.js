include_recipe 'dependencies'

node[:deploy].each do |application, deploy|
  opsworks_nodejs do
    deploy_data deploy
  end
end
