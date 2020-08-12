#
# Cookbook:: ddwrapper
# Recipe:: ntp.rb
#

#node.override['datadog']['ntp']['instances'] = [
#  {
#    'offset_threshold' => '60',
#    'host' => '169.254.169.123',
#    'port' => 'ntp',
#    'version' => '3',
#    'timeout' => '5',
#  },
#]

# Enable NTP Monitor using AWS environment
datadog_monitor 'ntp' do
  instances node['datadog']['ntp']['instances']
  logs node['datadog']['ntp']['logs']
  action :add
  notifies :restart, 'service[datadog-agent]' if node['datadog']['agent_start']
end
