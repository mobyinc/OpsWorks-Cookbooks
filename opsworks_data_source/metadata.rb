maintainer       "Moby, Inc"
maintainer_email "hello@mobyinc.com"
license          "MIT"
description      "Write data source attributes to a shared JSON file"

name   'opsworks_data_source'
recipe 'opsworks_data_source::configure', 'Configure the shared data source file.'

depends 'deploy'
