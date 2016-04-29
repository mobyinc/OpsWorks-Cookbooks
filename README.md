# OpsWorks Cookbooks
This is Moby’s set of frequently-used OpsWorks cookbooks. Each cookbook is a Git submodule that links to a repository.

To update the cookbooks to their latest versions:

```
git submodule update --remote
```

## Adding to OpsWorks
1. Enable custom Chef cookbooks and set this repository as the **Repository URL** ([more info here](http://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook-installingcustom-enable.html))
2. Run the [Update Custom Cookbooks](http://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook-installingcustom-enable-update.html) command if this is an existing instance
3. Run the [Execute Recipes](http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-commands.html) command to run a recipe outside the usual lifecycle

## Cookbooks
### [Redis](https://github.com/mobyinc/opsworks-redis)
Installs redis, sets up a service to run the redis server, enables CloudWatch logging.

Add these recipes to OpsWorks:

* **Setup**: `redisio::cwlog_config`, `redisio::cwlogs_install`, `redisio::install`
* **Shutdown**: `redisio::disable`

Add custom JSON to point to the log file for CloudWatch:

```json
{
  "cwlogs": {
    "rails_log_path": "/srv/www/<your_app_name>/shared/log/production.log"
  }
}
```

### [Sidekiq](https://github.com/drakerlabs/opsworks_sidekiq)
Sets up Monit-monitored processes for Sidekiq workers.

Add these recipes to OpsWorks:

* **Setup**: `opsworks_sidekiq::setup`
* **Configure**: `opsworks_sidekiq::configure`
* **Deploy**: `opsworks_sidekiq::deploy`
* **Undeploy**: `opsworks_sidekiq::undeploy`
* **Shutdown**: `opsworks_sidekiq::stop`

Add custom JSON to the stack reflecting your desired config (see the cookbook’s README for more info):

**<your_app_name> should match the name of the folder at `srv/www/<your_app_name>`.**

```json
{
  "sidekiq": {
    "<your_app_name>": {
      "worker": {
        "config" : {
          "concurrency": 5,
          "verbose": false,
          "queues": ["default"]
        }
      }
    }
  }
}
```

After deploying, Sidekiq should be started and monitored by Monit:

```
sudo monit status

> Process 'sidekiq_your_app_name-worker1'
  status                            running
  monitoring status                 monitored
  pid                               12345
  parent pid                        54321
  uptime                            4m
  ...
```
