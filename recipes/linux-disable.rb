#
# Cookbook:: ddwrapper
# Recipe:: linux-disable.rb
#

# This recipe is to be called to 'disable' the Datadog Agent System Probe

#
# Documentation: https://docs.datadoghq.com/network_performance_monitoring/installation/
# DD Agent System Probe Info: https://github.com/DataDog/chef-datadog/blob/master/recipes/system-probe.rb
#

execute 'remove system-probe immutable status' do
  command "chattr -i /etc/datadog-agent/system-probe.yaml"
  action :run
end

template "/etc/datadog-agent/system-probe.yaml" do # ~FC033
  source 'network/disable_system_probe.yaml.erb'
  owner 'dd-agent'
  group 'dd-agent'
  mode '0644'
end

execute 'remove system-probe immutable status' do
  command "chattr +i /etc/datadog-agent/system-probe.yaml"
  action :run
end

execute 'disable_system_probe_agent' do
  command <<-EOF
  sudo systemctl stop datadog-agent-sysprobe
  sudo systemctl disable datadog-agent-sysprobe
  sudo systemctl restart datadog-agent
  EOF
end

