#
# Cookbook:: ddwrapper
# Recipe:: default
#

# Workaround for permissions due to Carbon Black AV on Windows Server
if platform_family?('windows')
  include_recipe 'datadog::dd-agent' unless ::File.exist?("#{node['carbonblack']['edr']['install_dir']}/cb_sensor_windows.msi")
  include_recipe 'ddwrapper::windows-logs' unless ::File.exist?("#{node['carbonblack']['edr']['install_dir']}/cb_sensor_windows.msi")
else
  include_recipe 'datadog::dd-agent'
  include_recipe 'ddwrapper::linux-config'
  include_recipe 'ddwrapper::linux-logs'
end

