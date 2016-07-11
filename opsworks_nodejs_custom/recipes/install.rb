include_recipe 'dependencies'

node[:deploy].each do |application, deploy|
  OpsWorks::NodejsConfiguration.npm_install(application, node[:deploy][application], release_path, node[:opsworks_nodejs][:npm_install_options])
end
