# Adapted from unicorn::rails: https://github.com/aws/opsworks-cookbooks/blob/master/unicorn/recipes/rails.rb

node[:deploy].each do |application, deploy|

  instance = search("aws_opsworks_instance", "self:true").first
  app = search("aws_opsworks_app").first

  # Allow deploy user to restart workers
  template "/etc/sudoers.d/#{deploy[:user]}" do
    mode 0440
    source "sudoer.erb"
    variables :user => deploy[:user]
  end

  workers = node[:sidekiq][application].to_hash.reject {|k,v| k.to_s =~ /restart_command|syslog/ }
  config_directory = "#{deploy[:deploy_to]}/shared/config"

  workers.each do |worker, options|

    # Convert attribute classes to plain old ruby objects
    config = options[:config] ? options[:config].to_hash : {}
    config.each do |k, v|
      case v
      when Chef::Node::ImmutableArray
        config[k] = v.to_a
      when Chef::Node::ImmutableMash
        config[k] = v.to_hash
      end
    end

    # Generate YAML string
    yaml = YAML::dump(config)

    # Convert YAML string keys to symbol keys for sidekiq while preserving
    # indentation. (queues: to :queues:)
    yaml = yaml.gsub(/^(\s*)([^:][^\s]*):/,'\1:\2:')

    (options[:process_count] || 1).times do |n|
      file "#{config_directory}/sidekiq_#{worker}#{n+1}.yml" do
        mode 0644
        action :create
        content yaml
      end
    end
  end

  if instance['hostname'] == 'utility' && node[:sidekiq][application]
    template "#{node[:monit][:conf_dir]}/sidekiq_#{application}.monitrc" do
      mode 0644
      source "sidekiq_monitrc.erb"
      variables({
        :deploy => deploy,
        :application => application,
        :env => app['environment'],
        :workers => workers,
        :syslog => node[:sidekiq][application][:syslog]
      })
    end
  end

  template "#{node[:monit][:conf_dir]}/#{application}_api.monitrc" do
    mode 0644
    source "api_monitrc.erb"
    variables({
      :deploy => deploy,
      :env => app['environment'],
      :application => application
    })
  end

end
