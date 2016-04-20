node[:deploy].each do |application, deploy|
  template "logging.properties for #{application}" do
    path ::File.join(node['tomcat']['webapps_base_dir'], "#{application}", 'WEB-INF', 'classes', 'logging.properties')
    source 'logging.properties.erb'
    owner node['tomcat']['user']
    group node['tomcat']['group']
    mode 0644
    backup false
  end
end

directory '/var/log/coupons' do
  owner 'tomcat'
  group 'tomcat'
  mode '0666'
  action :create
end
