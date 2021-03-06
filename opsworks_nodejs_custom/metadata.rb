name        "opsworks_nodejs_custom"
description 'Installs and configures a Node.js application server'
maintainer  "Moby, Inc."
license     "Apache 2.0"
version     "1.0.0"

recipe 'opsworks_sidekiq::install',     'Runs npm install'

depends 'deploy'
depends 'opsworks_commons'
