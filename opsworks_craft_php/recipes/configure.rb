node[:deploy].each do |application, deploy|
  template "/etc/php5/apache2/php.ini" do
    cookbook 'opsworks_craft_php'
    source 'php.ini'
    mode '0660'
    owner 'root'
    group 'root'
  end

  # Ensure phg mycrypt command is run
  execute "execute php5enmod mcrypt" do
    command "sudo php5enmod mcrypt"
    action :nothing
  end

  # Upgrade node to 6.11.1
  execute "upgrade node version" do
    command "sudo npm cache clean -f; sudo npm install -g n; sudo n 6.11.1"
    action :nothing
  end
end


