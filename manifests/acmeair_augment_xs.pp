class samples::acmeair_augment_xs{
  include samples::params

  $wxs_serverdir = "${samples::wxs_install_root_final}${samples::params::wxs_serverdirName}"   
  
  # Create a WebSphere eXtreme Scale configuration
  file { "${wxs_serverdir}/acmeair":
        mode    => "0777",
        source  => "${wxs_serverdir}/gettingstarted/",
        ensure  => present,
        recurse => true,
        replace => true,
  } ->   
  # Customize the env.sh
  file { 'env.sh':
        path     => "${wxs_serverdir}/acmeair/env.sh",
        ensure   => file,
        content  => template("samples/${samples::params::env_file}.erb"),
        replace  => true,
        mode => 777, 
  } ->    
  # Apply Acme Air specific Configuration
  file { "${samples::params::deploymentconfig}":
        path     => "${wxs_serverdir}/acmeair/server/config/${samples::params::deploymentconfig}",
        ensure   => file,
        content  => template("samples/${samples::params::deploymentconfig}.erb"),
        replace  => true,
  } ->
  file { "${samples::params::objectgridconfig}":
        path     => "${wxs_serverdir}/acmeair/server/config/${samples::params::objectgridconfig}",
        ensure   => file,
        content  => template("samples/${samples::params::objectgridconfig}.erb"),
        replace  => true,
  } ->
  exec { "create_catalog_server":
    command     => "${wxs_serverdir}/acmeair/runcat.sh &",
    path        => "${samples::path}",
    timeout     => 1800,
    environment => ["JAVA_HOME=${samples::java_home_final}"],
  } ->    
  # Start the container server
  exec { "run_catalog_container":
    command     => "${wxs_serverdir}/acmeair/runcontainer.sh c0 &",
    path    => "${samples::path}",
    timeout     => 1800,
    environment => ["JAVA_HOME=${samples::java_home_final}"],
  } ->  
  #Sleep for the execs to complete. This is brittle  but these two  processes need to start.
  exec { "run_sleep":
    command     => "sleep 200",
    path    => "${samples::path}",
  } ->
  # load data into extreme scale
  exec { "load_data":
    command     => "java -cp ${samples::loader_class_path} com.acmeair.loader.Loader",
    path    => "${samples::path}",
    environment => ["JAVA_HOME=${samples::java_home_final}"],
  }
}
