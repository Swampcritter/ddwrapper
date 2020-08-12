# datadog_wrapper

About this cookbook:
======================
The get_datadog cookbook wraps the public datadog cookbook found at:  
**Supermarket:** https://supermarket.chef.io/cookbooks/datadog  
**Github:**  https://github.com/DataDog/chef-datadog


Configure Infrastructure Monitoring
---------
Infrastructure Monitoring is done by the datadog agent which is installed by the datadog recipe.
(See Getting Started for Details)  

**Infrastructure Monitoring Required Attributes**  
**Note:** Some attributes required by datadog are populated by the get_datadog or public datadog
cookbook automatically.  The below attributes are the ones required to be used by app teams.

| Config Value  | Attribute Structure          | Attribute Type | Example Value(s)                                    |
| ------------- | ---------------------------- | -------------- | --------------------------------------------------- |
|  api_key:     | ['datadog']['api_key']       | String         | *populated by get_datadog cookbook*                 |
|  tags:        | ['datadog']['tags']          | Array          | "tags": {"UAI": "UAI123", "APP_OWNER":"FANCYDOG"}   |



Configure Logs / Integrations for popular frameworks and services
---------
DataDog combines the installation, configuration and inclusion of logs for a popular frameworks using the datadog_monitor resource.  
The integrations collect additional metrics about the service running and can help provide additional metrics about a service.    
A list of available integrations are can be found here: https://docs.datadoghq.com/integrations/

**Integrations Setup**
To include the integration for a specific framework or service the *datadog_monitor* resource needs included in the desired recipe.
For more details view the datadog_monitor section from the datadog cookbook documentation:  https://github.com/DataDog/chef-datadog/blob/master/README.md

```ruby
datadog_monitor 'nginx'
```

**Suggested Attributes**  
| Config Value  | Attribute Structure          | Attribute Type | Example Value(s)                                    |
| ------------- | ---------------------------- | -------------- | --------------------------------------------------- |
|  logs:        | ['datadog']['nginx']['logs'] | String         | *see below*                                         |


```json
"datadog": {
  "nginx": {
    "logs": [
      {
        "type": "file",
        "path": "/var/log/nginx/api-mm-access.log",
        "source": "nginx",
        "service": "mm-api-balancer"
      },
      {
        "type": "file",
        "path": "/var/log/nginx/*error.log",
        "source": "nginx",
        "service": "mm-api-balancer"
      }
    ]
  }
}
```


Configure Logs for non-standard / supported frameworks
---------
DataDog does not have an integration available for every framework or product.  Logs can still be
configured, independent of a framework. JournalD for Linux is actually a custom written process so 
it has a combination of a unique pre-configuration recipe and then the variables are found in a conf.yaml
file as a template.


Configure APM Monitoring
---------
Application Performance Monitoring provides deep insight into your application’s performance.
