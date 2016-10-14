name "npm_role"
description "run Npm CB"

ruby_version = '2.1'

default_attributes \

override_attributes \

  gettaxi_npm_install: {
      deploy_env: "production"
  }

run_list [
  "gettaxi_npm_install"
]
