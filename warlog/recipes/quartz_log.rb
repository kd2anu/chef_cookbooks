directory '/var/log/coupons' do
  owner 'tomcat'
  group 'tomcat'
  mode '0766'
  action :create
end
