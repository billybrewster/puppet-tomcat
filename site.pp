$nexus_ip                    = hiera("nexus_ip")
$package_version             = hiera("package_version")

package { 'java-1.8.0-openjdk':
    ensure => 'installed',
  }

tomcat::install { '/opt/tomcat':
  source_url => 'https://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.85/bin/apache-tomcat-7.0.85.tar.gz',
}
tomcat::instance { 'default':
  catalina_home => '/opt/tomcat',
}
tomcat::war { 'hello-world.war':
  catalina_base => '/opt/tomcat',
  war_source    => "http://$nexus_ip:8081/nexus/content/repositories/releases/com/efsavage/hello-world-war/$package_version/hello-world-war-$package_version.war",
}
