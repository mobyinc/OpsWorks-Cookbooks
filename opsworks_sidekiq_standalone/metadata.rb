maintainer       "Draker"
maintainer_email "devops@drakerenergy.com"
license          "MIT"
description      "Configure and deploy sidekiq on opsworks."

name   'opsworks_sidekiq_standalone'
recipe 'opsworks_sidekiq_standalone::setup',     'Set up sidekiq worker.'
recipe 'opsworks_sidekiq_standalone::configure', 'Configure sidekiq worker.'
recipe 'opsworks_sidekiq_standalone::deploy',    'Deploy sidekiq worker.'
recipe 'opsworks_sidekiq_standalone::undeploy',  'Undeploy sidekiq worker.'
recipe 'opsworks_sidekiq_standalone::stop',      'Stop sidekiq worker.'

depends 'deploy'
depends 'rails'
