service "monit" do
  supports :status => false, :restart => true, :reload => true
  action :nothing
end

# node[:deploy].each do |application, deploy|
#   execute "restart API" do
#     command "monit restart #{application}_api"
#   end

#   execute "restart sidekiq worker 1" do
#     command "monit restart sidekiq_#{application}-worker1"
#   end

#   execute "restart sidekiq worker 2" do
#     command "monit restart sidekiq_#{application}-worker2"
#   end
# end
