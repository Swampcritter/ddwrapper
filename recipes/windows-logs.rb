#
# Cookbook:: ddwrapper
# Recipe:: windows-logs.rb
#

# frozen_string_literal: true

template "#{node['datadog']['service-account']['win_dir']}/conf.yaml" do # ~FC033
  source 'windows/conf.yaml.erb'
  notifies :restart, 'service[datadog-agent]' if node['datadog']['agent_start']
end

ruby_block 'waiting for ddagent running state' do
  block do
    service_name = 'datadogagent'
    service_status = powershell_out("(Get-Service -name \"#{service_name}\").Status")
    until service_status.stdout[/Running/]
      Chef::Log.info "Waiting for #{service_name} to start"
      sleep 5
      service_status = powershell_out("(Get-Service -name \"#{service_name}\").Status")
    end
  end
end

# Enable Windows Server Event Log Monitoring
#datadog_monitor 'win32_event_log' do
#  init_config node['datadog']['win32_event_log']['init_config']
#  instances node['datadog']['win32_event_log']['instances']
#  logs node['datadog']['win32_event_log']['logs']
#  action :add
#  notifies :restart, 'service[datadog-agent]' if node['datadog']['agent_start']
#end

