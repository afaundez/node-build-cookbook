# Testing

Tested using chef-workstation from Homebrew

# Lint and Style

```sh
CHEF_LICENSE=accept-no-persist delivery local lint
```

# Unit specs

```
berks install --except integration
CHEF_LICENSE=accept-no-persist delivery unit
```

# Integration tests

Check [Test Kitchen](https://kitchen.ci/docs/getting-started/running-test).

- dokken/docker: `KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen test`
- vagrant/virtualbox: `kitchen test`
