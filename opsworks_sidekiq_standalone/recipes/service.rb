service "monit" do
  supports :status => false, :restart => true, :reload => true
  action :nothing
end

node[:deploy].each do |application, deploy|
  execute "restart app #{application}" do
    command "monit restart sidekiq_#{application}-worker1"
    command "monit restart sidekiq_#{application}-worker2"
    command "monit restart #{application}_api"
  end
end
