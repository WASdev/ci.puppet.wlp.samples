ci.puppet.wlp.samples
=====================

Puppet modules to run Liberty profile samples #devops 


##Samples Provided

Configuring AcmeAir and augmenting the eXtreme scale with the data needed for AcmeAir.


##Installables

`AcmeAir` 

The dependencies of AcmeAir application would be dowloaded when they are built.

The following are a list of dependencies should be
    
    acmeair-common-1.0-SNAPSHOT.jar        cglib-2.2.2.jar            
    acmeair-loader-1.0-SNAPSHOT.jar        commons-logging-1.1.1.jar  
    acmeair-services-1.0-SNAPSHOT.jar      guava-12.0.jar             
    acmeair-services-wxs-1.0-SNAPSHOT.jar  jsr305-1.3.9.jar           
    aopalliance-1.0.jar                    logback-classic-1.0.6.jar  
    asm-3.3.1.jar                          logback-core-1.0.6.jar     
    aspectjrt-1.6.8.jar                    objectgrid-8.6.0.2.jar     
    aspectjweaver-1.6.8.jar                slf4j-api-1.6.5.jar
    spring-aop-3.1.2.RELEASE.jar		   spring-asm-3.1.2.RELEASE.jar
    spring-beans-3.1.2.RELEASE.jar         spring-context-3.1.2.RELEASE.jar
    spring-core-3.1.2.RELEASE.jar          spring-expression-3.1.2.RELEASE.jar
    spring-tx-3.1.2.RELEASE.jar

The above dependencies should be placed in `<puppet_module_root>/wxs/files/dependantLibs`



##Modules

`samples::acmeair_copy_files` This module will copy all necessary dependencies.

`samples::acmeair_augment_xs` This module will augment the eXtreme scale with the data needed by the AcmeAir application.


##Installing AcmeAir

AcmeAir can be installed in two topologies

1) AcmeAir with eXtreme scale installed and configured in the same node
https://github.com/acmeair/acmeair/wiki/WebSphere-Liberty-To-WebSphere-eXtreme-Scale-Setup


2) AcmeAir installed in a different node and eXtreme scale installed in a different node. This topology can be used to have multiple AcmeAir applications connect to a single eXtreme scale node.

https://github.com/acmeair/acmeair/wiki/Distributed-Environment-Setup

If the customer wishes to use the second topology then the AcmeAir application has to be modified based on the instructions provided in the above link and then rebuilt and the new build has to be used for deploying.

Current version does not support dynamic selection of host where the eXtreme scale is hosted.So, a prior decision has to be made on where should the eXtreme scale be hosted.

##Customisations

The following are the customisations that are provided.

[*dependantLibs*]
The path to the directory where the list of dependent libs for acme air are located.
Default : $puppetFileRoot/lib    When using all defaults : /home/puppetuser/liberty/lib

[*puppetFileRoot*]
The parent directory in which installables and application directories are specified. This serves as a directory where the data
from the Master is copied for agent to use during installation.
Default : /home/puppetuser/liberty

[*wxs_install_root*]
This indicates the location where the ExtremeScale is installed. If you modify the location using "install_root" when
installing Wxs module then the same location has to be specified here.
Default : /opt/IBM/

[*java_home*]
The path to the JDK.
Default : /usr/lib/jvm/java-1.6.0

##Sample Usage

The following is a sample usage.

        class { "samples":
                dependantLibs => "/home/puppetuser/lib",
               } ->
        class { "samples::acmeair_copy_files":}
        

## Notice

 © Copyright IBM Corporation 2013, 2014.

## License

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.