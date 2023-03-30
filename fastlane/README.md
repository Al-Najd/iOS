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

### ios test

```sh
[bundle exec] fastlane ios test
```

Runs Unit Tests & Calculates Coverage for specific parts of the project

### ios build_for_internal_testers

```sh
[bundle exec] fastlane ios build_for_internal_testers
```

Builds and prepare Internal Testers

### ios build_for_staging

```sh
[bundle exec] fastlane ios build_for_staging
```

Builds and prepare Staging build

### ios build_for_production

```sh
[bundle exec] fastlane ios build_for_production
```

Builds and prepare production build

### ios ci_build_for_adhoc

```sh
[bundle exec] fastlane ios ci_build_for_adhoc
```

Build and prepare for AdHoc CI providers

### ios ci_build_for_appstore

```sh
[bundle exec] fastlane ios ci_build_for_appstore
```

Build and prepare for AdHoc CI providers

### ios make_changelog_more_readable

```sh
[bundle exec] fastlane ios make_changelog_more_readable
```



### ios make_changelogs

```sh
[bundle exec] fastlane ios make_changelogs
```



### ios setup_for_ci_if_needed

```sh
[bundle exec] fastlane ios setup_for_ci_if_needed
```



### ios onboard

```sh
[bundle exec] fastlane ios onboard
```

Add new comer's Device to Profiles

### ios match_onboarding

```sh
[bundle exec] fastlane ios match_onboarding
```



### ios add_devices

```sh
[bundle exec] fastlane ios add_devices
```

Asks user to input their mac's UUID & iPhone's UUID to add them to the profiles

### ios push_notifications_dev

```sh
[bundle exec] fastlane ios push_notifications_dev
```

Creates Push Notifications Certs from customer.dev

### ios push_notifications_prod

```sh
[bundle exec] fastlane ios push_notifications_prod
```

Creates Push Notifications Certs from customer.dev

### ios push_notifications_staging

```sh
[bundle exec] fastlane ios push_notifications_staging
```

Creates Push Notifications Certs from customer.dev

### ios sync_production_release_branch

```sh
[bundle exec] fastlane ios sync_production_release_branch
```

Opens a PR to develop & master

### ios sync_release_branch

```sh
[bundle exec] fastlane ios sync_release_branch
```

Opens a PR to develop & master

### ios gitlab_release

```sh
[bundle exec] fastlane ios gitlab_release
```

Creates a new release on Gitlab

### ios push_to_testflight

```sh
[bundle exec] fastlane ios push_to_testflight
```

Uploads the app to Testflight

### ios prepare_for_release

```sh
[bundle exec] fastlane ios prepare_for_release
```


  After versioning to a newer version, this lane will:
  1. Checks current version
  2. Calculates current branch
  3. If current branch is release/VERSION_ID, then it won't checkout, else will create this branch
  4. Commits & Pushes the changes
  5. Creates a new tag
  6. Pushes the tag
  

### ios validate_tag

```sh
[bundle exec] fastlane ios validate_tag
```



### ios add_tag_to_git

```sh
[bundle exec] fastlane ios add_tag_to_git
```



### ios ensure_being_on_develop

```sh
[bundle exec] fastlane ios ensure_being_on_develop
```



### ios setup_environment

```sh
[bundle exec] fastlane ios setup_environment
```

Sets up Environment Variables provided from CAFU

### ios release

```sh
[bundle exec] fastlane ios release
```


  Automated Release, expects release env & version number & Build Number
  Supported Envs: qa, staging, production
  

### ios release_according_to_environment

```sh
[bundle exec] fastlane ios release_according_to_environment
```



### ios interactive_release

```sh
[bundle exec] fastlane ios interactive_release
```

Helps devs to release easier without much hassle

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Releases the app to TestFlight for Internal Testers

### ios staging

```sh
[bundle exec] fastlane ios staging
```

Releases the app to TestFlight for Staging

### ios ci_beta

```sh
[bundle exec] fastlane ios ci_beta
```

Releases app internally to TestFlight from CI environment

### ios production

```sh
[bundle exec] fastlane ios production
```

Release the app directly to the AppStore

### ios ci_production

```sh
[bundle exec] fastlane ios ci_production
```

Release the app directly to the AppStore

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
