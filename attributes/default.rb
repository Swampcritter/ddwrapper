
default['datadog']['api_key'] = ''
default['datadog']['application_key'] = ''

default['datadog']['agent_major_version'] = '7'
default['datadog']['agent_package_action'] = 'upgrade'

default['datadog']['enable_process_agent'] = true
default['datadog']['enable_trace_agent'] = true

# Used for eBPF on Linux instances (if available)
default['datadog']['system_probe']['enabled'] = false

default['datadog']['enable_logs_agent'] = true
default['datadog']['extra_config']['logs_config'] = { 'use_port_443' => true, 'use_compression' => true }

default['datadog']['service-account']['username'] = 'dd-agent'
default['datadog']['service-account']['group'] = 'dd-agent'
default['datadog']['service-account']['directory'] = 'C:\\temp'
default['datadog']['service-account']['win_dir'] = 'C:\\ProgramData\\Datadog\\conf.d\\win32_event_log.d'

default['datadog']['dd_agent']['java_agent']['source'] = 'https://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.datadoghq&a=dd-java-agent&v=LATEST'

# Deployment code for Carbon Defense on Windows (part of deployment check)
default['carbonblack']['edr']['install_dir'] = 'C:\\CBDefense'

# Override ntp server settings to point at AWS endpoint
default['datadog']['ntp']['instances'] = [
  {
    'offset_threshold' => '60',
    'host' => '169.254.169.123',
    'port' => 'ntp',
    'version' => '3',
    'timeout' => '5',
  },
]

