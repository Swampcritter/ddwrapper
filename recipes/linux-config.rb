#
# Cookbook:: ddwrapper
# Recipe:: linux-preconfig.rb
#

execute 'dd-agent for systemd-journal group' do
  command "usermod -a -G systemd-journal dd-agent"
  action :run
end

