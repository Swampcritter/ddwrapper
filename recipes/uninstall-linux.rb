#
# Cookbook:: ddwrapper
# Recipe:: linux-uninstall.rb
#

# Uninstall DD Agent from Linux platform
bash 'uninstall_ddagent_linux' do
  code <<-EOF
  sudo chattr -i /etc/datadog-agent/system-probe.yaml
  sudo yum -y remove datadog-agent
  sudo rm -rf /etc/datadog-agent
  sudo rm -rf /opt/datadog-agent
  EOF
end

