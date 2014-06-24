# Class: samples
# The samples module aims to provide various manifests that would help configure and deploy samples on WebSphere liberty profile.
#
# Parameters
# 
#    [*dependantLibs*]
#    The path to the directory where the list of dependent libs for acme air are located.
#    Default : $puppetFileRoot/lib    When using all defaults : /home/puppetuser/liberty/lib
#
#    [*puppetFileRoot*]
#    The parent directory in which installables and application directories are specified. This serves as a directory where the data 
#    from the Master is copied for agent to use during installation. 
#    Default : /home/puppetuser/liberty
#
#    [*wxs_install_root*]
#    This indicates the location where the ExtremeScale is installed. If you modify the location using "install_root" when 
#    installing Wxs module then the same location has to be specified here.
#    Default : /opt/IBM/
#
#    [*java_home*]
#    The path to the JDK.
#    Default : /usr/lib/jvm/java-1.6.0
#
#
# Sample Usage
#
#        class { "samples":
#                dependantLibs => "/home/puppetuser/lib",
#               } ->
#        class { "samples::acmeair_copy_files":}
#
# 

class samples (
  $dependantLibs       = 'UNSET',
  $puppetFileRoot      = 'UNSET',
  $wxs_install_root    = 'UNSET',
  $java_home           = 'UNSET'

) {
  include samples::params

  $dependantLibs_final = $dependantLibs? {
    'UNSET' => $::samples::params::dependantLibs,
    default => $dependantLibs,    
  }  
  $puppetFileRoot_final = $puppetFileRoot? {
    'UNSET' => $::samples::params::puppetFileRoot,
    default => $puppetFileRoot,
  }
  $wxs_install_root_final = $wxs_install_root? {
    'UNSET' => $::samples::params::wxs_install_root,
    default => $wxs_install_root,
  }
  $java_home_final = $java_home ? {
    'UNSET' => $::samples::params::java_home,
    default => $java_home,
  }

  $path               = "${::samples::java_home_final}/bin:/opt/puppet/bin:${::samples::wxs_install_root_final}/${::samples::params::baseDir}/wlp/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"

  $sample_cp          = "$SAMPLE_COMMON_CLASSPATH:${::samples::dependantLibs_final}/acmeair-common-1.0-SNAPSHOT.jar:${::samples::dependantLibs_final}/acmeair-services-wxs-1.0-SNAPSHOT.jar:${::samples::dependantLibs_final}/commons-logging-1.1.1.jar"

  $loader_class_path  = "$sample_cp:${::samples::dependantLibs_final}/acmeair-loader-1.0-SNAPSHOT.jar:${::samples::dependantLibs_final}/acmeair-services-1.0-SNAPSHOT.jar:${::samples::dependantLibs_final}/aspectjweaver-1.6.8.jar:${::samples::dependantLibs_final}/aspectjrt-1.6.8.jar:${::samples::dependantLibs_final}/cglib-2.2.2.jar:${::samples::dependantLibs_final}/spring-tx-3.1.2.RELEASE.jar:${::samples::dependantLibs_final}/spring-core-3.1.2.RELEASE.jar:${::samples::dependantLibs_final}/spring-context-3.1.2.RELEASE.jar:${::samples::dependantLibs_final}/spring-beans-3.1.2.RELEASE.jar:${::samples::dependantLibs_final}/spring-expression-3.1.2.RELEASE.jar:${::samples::dependantLibs_final}/spring-aop-3.1.2.RELEASE.jar:${::samples::dependantLibs_final}/spring-asm-3.1.2.RELEASE.jar:${::samples::dependantLibs_final}/asm-3.3.1.jar:${::samples::dependantLibs_final}/aopalliance-1.0.jar:${::samples::dependantLibs_final}/jsr305-1.3.9.jar:${::samples::dependantLibs_final}/guava-12.0.jar:${::samples::dependantLibs_final}/slf4j-api-1.6.5.jar:${::samples::dependantLibs_final}/logback-core-1.0.6.jar:${::samples::dependantLibs_final}/logback-classic-1.0.6.jar:${::samples::dependantLibs_final}/objectgrid-8.6.0.2.jar"

notify{"${samples::puppetFileRoot_final}": }
}
