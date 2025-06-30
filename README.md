[![Chef cookbook](https://img.shields.io/cookbook/v/node_build.svg)]()
[![Travis](https://img.shields.io/travis/afaundez/node-build-cookbook.svg)]()
# node-build Chef Cookbook

Chef cookbook for node-build.

# Usage

## Cookbook

```ruby
cookbook 'node_build', '~> 1.0.4'
```

## Resource

### Standalone install

```ruby
node_build_standalone_install 'node-build'
```

#### Properties

| Property  | Type    | Default       | Description |
| --------- | ------- | ------------- | ----------- |
| prefix    | String  | `/usr/local`  | node-build will be installed in `prefix/share/node-build`. |

Name property is not used.

### Plugin install

```ruby
node_build_plugin_install '/path/to/install/node-build'
```

#### Properties

| Property        | Type    | Default                                   | Description |
| --------------- | ------- | ----------------------------------------  | ----------- |
| node_build_root | String  |                                           | Path to install node-build: `/home/myuser/.nodenv/plugins/node-build` |
| owner           | String  |                                           | Owner responsible of `node_build_path`.  |
| group           | String  |                                           | Group responsible of `node_build_path`.  |
| git_url         | String  | https://github.com/nodenv/node-build.git  | You can give an alternative git URL  |
| git_revision    | String  | master                                    | You can choose a branch, tag, or commit to be synchronized with git  |
| user            | String  |                                           | Deprecated. Use `owner` instead  |

`node_build_root` is the name property.