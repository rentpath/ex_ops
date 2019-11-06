# ExOps

Provides standardized support for obtaining environment, version, and heartbeat information in JSON format

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Installation](#installation)
  - [Default settings](#default-settings)
    - [Overide via `config.exs`](#overide-via-configexs)
  - [BUILD-INFO format](#build-info-format)
  - [DEPLOY-INFO format](#deploy-info-format)
  - [Configure routes](#configure-routes)
    - [Routes](#routes)
      - [`/ops/version`](#opsversion)
      - [`/ops/heartbeat`](#opsheartbeat)
      - [`/ops/env`](#opsenv)
- [Running the tests](#running-the-tests)
- [Contributing](#contributing)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

```elixir
def deps do
  [{:ex_ops, "~> 1.1.0"}]
end
```

### Default settings
```elixir
build_info_regex: ~r/:\s([\w|-]+)/,
deploy_info_regex: ~r/:\s\"(.+)\"\n/,
info_files: %{
  build_info_file: "../BUILD-INFO",
  deploy_info_file: "../DEPLOY-INFO",
  previous_build_info_file: "../PREVIOUS-BUILD-INFO",
  previous_deploy_info_file: "../PREVIOUS-DEPLOY-INFO",
}
```

#### Overide via `config.exs`
```elixir
config :ex_ops,
  build_info_regex: <CUSTOM_REGEX>,
  deploy_info_regex: <CUSTOM_REGEX>,
  info_files: %{
    build_info_file: <PATH_TO_FILE>,
    deploy_info_file: <PATH_TO_FILE>,
    previous_build_info_file: <PATH_TO_FILE>,
    previous_deploy_info_file: <PATH_TO_FILE>,
  }
```

### BUILD-INFO format
```
---
version: 20160613-100-09d5671
build_number: 100
git_commit: 09d5671224b03969c629d9265417bc82c4aac48f
```

### DEPLOY-INFO format
```
---
deploy_date: "2016-12-06 18:04:27"
```

### Configure routes

Add following to your `router.ex`, `scope` defaults to `/ops` but can be set to anything you like

```elixir
scope "/ops" do
  get "/:path", ExOps.Plug, []
end
```

#### Routes

##### `/ops/version`
```json
{
  "host": "localhost",
  "deployment": {
    "tag": "20161129-23-c736197",
    "short_commit_sha": "c736197",
    "previous": {
      "tag": "20161129-22-d7d5369",
      "short_commit_sha": "d7d5369",
      "date": "2016-12-06 17:59:15",
      "commit_sha": "d7d5369a24870ac807da79d4e67a78c8e0ff25b",
      "build_number": "22"
    },
    "date": "2016-12-06 18:04:27",
    "commit_sha": "c7361976bdcb5bdf2cf4fd31b027ddc8dc5e598b",
    "build_number": "23"
  }
}
```

##### `/ops/heartbeat`
```json
{
  "status": 200,
  "message": "Ok"
}
```

##### `/ops/env`
- Not implemented

## Running the tests

Test include
- Linter via [Credo](https://hex.pm/packages/credo)
- Coverage via [Excoveralls](https://hex.pm/packages/excoveralls)
- run tests: `script/test`
- run tests with coverage: `script/test --coverage`

## Contributing
-  Follow the instructions above to install `elixir` and get the repo running.
-  If you modify code, add a corresponding test (if applicable).
-  Create a Pull Request (please squash to one concise commit).
-  Thanks!

## License
[MIT](https://github.com/rentpath/ex_ops/blob/master/LICENSE)

