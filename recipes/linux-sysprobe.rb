#
# Cookbook:: ddwrapper
# Recipe:: linux-sysprobe.rb
#

#
# Documentation: https://docs.datadoghq.com/network_performance_monitoring/installation/
# DD Agent System Probe Info: https://github.com/DataDog/chef-datadog/blob/master/recipes/system-probe.rb
#

template "/etc/datadog-agent/system-probe.yaml" do # ~FC033
  source 'network/enable_system_probe.yaml.erb'
  owner 'dd-agent'
  group 'dd-agent'
  mode '0644'
end

execute 'make system-probe immutable' do
  command "chattr +i /etc/datadog-agent/system-probe.yaml"
  action :run
end

selinux_state "Disable SELinux" do
  action :disabled
end

bash 'clean_linux_instance_yum' do
  code <<-EOF
  sudo yum clean metadata
  sudo yum clean dbcache
  sudo yum clean all
  EOF
end

bash 'download_kernel_packages' do
  cwd '/tmp'
  code <<-EOF
  sudo yum-config-manager --enable base-debuginfo
  wget http://debuginfo.centos.org/7/x86_64/kernel-debuginfo-common-x86_64-3.10.0-1127.el7.x86_64.rpm
  wget http://debuginfo.centos.org/7/x86_64/kernel-debug-debuginfo-3.10.0-1127.el7.x86_64.rpm
  wget http://debuginfo.centos.org/7/x86_64/kernel-debuginfo-3.10.0-1127.el7.x86_64.rpm
  wget http://debuginfo.centos.org/7/x86_64/kernel-plus-debuginfo-3.10.0-1127.el7.centos.plus.x86_64.rpm
  wget http://debuginfo.centos.org/7/x86_64/kernel-plus-debuginfo-common-x86_64-3.10.0-1127.el7.centos.plus.x86_64.rpm
  wget http://debuginfo.centos.org/7/x86_64/kernel-plus-tools-debuginfo-3.10.0-1127.el7.centos.plus.x86_64.rpm
  EOF
  ignore_failure true
  not_if { ::File.exist?('/tmp/kernel-plus-tools-debuginfo-3.10.0-1127.el7.centos.plus.x86_64.rpm') }
end

#Dir.glob("/tmp/kernel-*.rpm").each do |pkg|
#   rpm_package pkg do
#    source pkg
#    action :install
#   end
#end

bash 'install_eBBF_kernel_needs' do
  cwd '/tmp'
  code <<-EOF
  sudo yum -y localinstall kernel-*
  EOF
end

bash 'setup_eBPF_linux' do
  cwd '/tmp'
  code <<-EOF
  sudo yum -y install bcc-tools
  sudo yum -y install systemtap systemtap-devel systemtap-runtime
  sudo yum -y install bpftool
  EOF
  not_if { ::File.exist?('/usr/share/bcc/tools/opensnoop') }
end

execute 'enable_system_probe_agent' do
  command <<-EOF
  sudo systemctl restart datadog-agent-sysprobe
  sudo systemctl enable datadog-agent-sysprobe
  sudo systemctl restart datadog-agent
  EOF
end

