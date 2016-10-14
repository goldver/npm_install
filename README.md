
npm_install Cookbook
============================

This cookbook will install NPM

Attributes
==================
#### npm_install::default

| Key | Type | Description | Default |
| --- | ---- | ----------- | ------- |
| ['npm_install']['deploy_env'] | String | environment variable | 'stage' |
| ['npm_install']['npm_version'] | String | Npm version | '3.10.7' |

Usage
==================
#### 'npm_install'::default

Just include `npm_install` in your cookbook:

    include_recipe 'npm_install'

If you wish to change your environment, for example: 'production'

	{
      npm_install: {
          deploy_env: "production"
       }   
	}

If you wish to change an Npm version, for example '3.10.8':

	{
      npm_install: {
          npm_version: "3.10.8"
       }   
	}

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Michael Vershinin

Support
-------------------
goldver@gmail.com


