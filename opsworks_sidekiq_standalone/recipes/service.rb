service "monit" do
  supports :status => false, :restart => true, :reload => true
  action :nothing
end

node[:deploy].each do |application, deploy|
  execute "restart monit processes" do
    command "monit -g #{application} restart"
  end
end
