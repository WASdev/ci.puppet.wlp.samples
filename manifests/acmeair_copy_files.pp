class samples::acmeair_copy_files {
    file { "${samples::puppetFileRoot_final}": ensure => "directory", } ->
    file { "dependantLibs":
    path    => "${samples::dependantLibs_final}",
    mode    => 777,
    owner   => root,
    group   => root,
    ensure => directory,
    recurse => true,
    source  => "puppet:///modules/samples/dependantLibs",
  } 
}
