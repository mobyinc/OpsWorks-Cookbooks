service "monit" do
  supports :status => false, :restart => true, :reload => true
  action :nothing
end


node[:deploy].each do |application, deploy|

  # Overwrite the unicorn restart command declared elsewhere
  # Apologies for the `sleep`, but monit errors with "Other action already in progress" on some boots.
  execute "restart app #{application}" do
    command "monit restart sidekiq_#{application}-worker1"
    command "monit restart sidekiq_#{application}-worker2"
    command "monit restart #{application}_api"
    action :nothing
  end

end
