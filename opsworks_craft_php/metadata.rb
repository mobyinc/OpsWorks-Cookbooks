maintainer       "Moby, Inc"
maintainer_email "hello@mobyinc.com"
license          "MIT"
description      "Write a default php.ini compatible with Craft CMS"

name   'opsworks_craft_php'
recipe 'opsworks_craft_php::configure', 'Configure the php.ini file.'

depends 'deploy'
