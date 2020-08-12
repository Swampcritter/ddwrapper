#
# Cookbook:: ddwrapper
# Recipe:: uninstall
#

# Determine the environment for uninstallation of DataDog Agent
if platform_family?('windows')
  include_recipe 'ddwrapper::uninstall-windows'
else
  include_recipe 'ddwrapper::uninstall-linux'
end

