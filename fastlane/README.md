fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios setup_for_ci_if_needed

```sh
[bundle exec] fastlane ios setup_for_ci_if_needed
```



### ios handle_versioning

```sh
[bundle exec] fastlane ios handle_versioning
```

Handles any versionings and Changelogs maintenance

### ios build_for_app_store_distribtion

```sh
[bundle exec] fastlane ios build_for_app_store_distribtion
```

Builds and prepare for exporting the app to the App Store

### ios push_to_testflight

```sh
[bundle exec] fastlane ios push_to_testflight
```

Uploads the app to Testflight

### ios sync_git

```sh
[bundle exec] fastlane ios sync_git
```

Syncs remote git with the local

### ios sentry_wetwork

```sh
[bundle exec] fastlane ios sentry_wetwork
```

Uploads dSYMs to Sentry, Creates a Release Deployment, and specifies the commits

### ios beta

```sh
[bundle exec] fastlane ios beta
```



### ios test_slack

```sh
[bundle exec] fastlane ios test_slack
```



----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
