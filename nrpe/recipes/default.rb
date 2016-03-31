user node[:nrpe][:user] do
  action :create
  system true
  shell "/bin/false"
end

directory node[:nrpe][:dir] do
  owner "icinga"
  mode "0755"
  action :create
end

remote_directory "/usr/local/nagios" do
  source "nrpe_files"
  owner "icinga"
  group "icinga"
  mode "0755"
  recursive true
  action :create_if_missing
end

#execute "fix_permission" do
#  command "sudo chown -R icinga:icinga /usr/local/nagios/*"
#  user "root"
#end

bash "fix_permission" do
  code "sudo chown -R icinga:icinga /usr/local/nagios/*"
end

template "/etc/init.d/nrpe" do
  source "nrpe.erb"
  mode "0755"
  owner "root"
  group "root"
end

bash "add_service" do
  code "sudo chkconfig --add nrpe"
  not_if "chkconfig --list |grep -i nrpe"
end

service "nrpe" do
  action [:enable, :start]
end
