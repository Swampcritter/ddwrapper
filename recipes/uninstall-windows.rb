# Cookbook:: ddwrapper
# Recipe:: uninstall-windows
#

# Uninstall DataDog Agent via PowerShell
powershell_script 'uninstall_datadog_agent_windows' do
  cwd node['datadog']['service-account']['directory']
  code <<-EOF
  (Get-WmiObject -Class Win32_Product -Filter "Name='Datadog Agent'" -ComputerName . ).Uninstall()
  EOF
end
