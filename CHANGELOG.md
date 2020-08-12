ddwrapper CHANGELOG
===================

This file is used to list changes made in each version of the datadog wrapper cookbook.

0.0.1
------
- [maworsham@gmail.com]
  * Recode datadog agent installation for linux and windows platforms
  * Added log compression capabilities 
  * Added capabilities for log aggregation for system-related logs
  *  Adds the java recipe which will install the java apm agent which can then be
      attached to a jvm at start
  *  Added the tomcat recipe which wraps the datadog tomcat recipe
