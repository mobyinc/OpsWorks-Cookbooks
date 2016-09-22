node[:deploy].each do |application, deploy|
  template "/etc/php5/apache2/php.ini" do
    cookbook 'opsworks_craft_php'
    source 'php.ini'
    mode '0660'
    owner 'root'
    group 'root'
  end
end
