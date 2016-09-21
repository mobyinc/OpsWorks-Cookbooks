node[:deploy].each do |application, deploy|
  template "#{deploy[:deploy_to]}/shared/config/data_source.json" do
    cookbook 'opsworks_data_source'
    source 'data_source.json.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
    variables(
      :database => deploy[:database]
    )
    only_if do
      File.exists?("#{deploy[:deploy_to]}/shared/config")
    end
  end
end
