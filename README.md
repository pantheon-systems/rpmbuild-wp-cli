# RPM for wp-cli

This repository builds an RPM for wp-cli.

## Relevant wp-cli RPM names

- wp-cli: Legacy RPM containing wp-cli and wp_launch_check
- wp-cli1: RPM containing only wp-cli (version 1.x)
- wp-launch-check-1.x: RPM containing only wp_launch_check 1.x

The RPM filename built by this repository is:
```
wp-cli1-1.0.0-201607271418.noarch.rpm
{name }-{ver}-{iteration }.{arch}.rpm
```
The iteration number is the Circle build number for officiel builds, and a timestamp (YYYYMMDDhhmm) for locally-produced builds.
## Install Location

This rpm installs:

/opt/pantheon/wp-cli1/wp-cli.phar

## Releasing to Package Cloud

CircleCI has automatic deployment of RPMs to Package Cloud configured.

When tests pass for a PR:  publish to pantheon/internal-staging/fedora/#.

When tests pass on master: publish to pantheon/internal/fedora/#.

In the example, # is the fedora build number (19, 20, 22). Note that wp-cli is only installed on app servers, and there are no app servers on anything prior to f22; therefore, at the moment, we are only building for f22.

To release a new version of wp-cli, simply update the VERSION.txt file and commit. Run `make` to build locally. Create a PR to have an RPM built and pushed to Package Cloud internal-staging via Circle CI. Merge the PR to have the RPM pushed to Package Cloud internal.

Note: The rpm on internal-staging and internal will not be exactly the same; they will differ in their build timestamp. 

## Provisioning wp-cli on Pantheon

Pantheon will automatically install any new RPM that is deployed to Package Cloud. This is controlled by [pantheon-cookbooks/wp-cli](https://github.com/pantheon-cookbooks/wp-cli/blob/master/recipes/default.rb).

## wp-cli RPM versioning strategy

wp-cli 1.x is compatible down to WordPress 3.7, so we do not need to maintain the cp-cli-0.x RPMs concurrently with wp-cli 1.x.
