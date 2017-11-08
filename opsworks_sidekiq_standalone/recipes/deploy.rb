node[:deploy].each do |application, deploy|
  template "#{deploy[:deploy_to]}/shared/config/memcached.yml" do
    cookbook "rails"
    source "memcached.yml.erb"
    mode 0660
    owner deploy[:user]
    group deploy[:group]
    variables(:memcached => (deploy[:memcached] || {}), :environment => deploy[:rails_env])
  end
end

monit 'monit' do
  action :reload
end
