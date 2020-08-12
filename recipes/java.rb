#
# Cookbook:: ddwrapper
# Recipe:: java
#

# Follows instructions from:  https://docs.datadoghq.com/tracing/setup/java/

include_recipe 'ddwrapper::default'

if node['platform_family'] == 'windows'
  # TODO: This attriute needs defined before this can be used on windows
  # default['dd-agent']['install_dir'] = ''
end

if node['platform_family'] == 'rhel'
  node.default['datadog']['dd_agent']['install_dir'] = '/opt/datadog-agent'
end

java_agent_dir = "#{node['datadog']['dd_agent']['install_dir']}/java-agent"
java_agent = 'dd-java-agent.jar'

directory java_agent_dir.to_s do
  owner 'dd-agent'
  group 'dd-agent'
  mode '0755'
end

remote_file "#{java_agent_dir}/#{java_agent}" do
  source "#{node['datadog']['dd_agent']['java_agent']['source']}" # ~FC002
  owner 'dd-agent'
  group 'dd-agent'
  mode '0755'
end
