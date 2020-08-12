#
# Cookbook:: ddwrapper
# Recipe:: linux-logs.rb
#
#

directory "/etc/datadog-agent/conf.d/journald.d" do
  owner node['datadog']['service-account']['username']
  group node['datadog']['service-account']['group']
  mode '0755'
  action :create
end

template "/etc/datadog-agent/conf.d/journald.d/conf.yaml" do # ~FC033
  source 'journald/conf.yaml.erb'
  user node['datadog']['service-account']['username']
  group node['datadog']['service-account']['group']
  mode '0644'
  notifies :restart, 'service[datadog-agent]' if node['datadog']['agent_start']
end

