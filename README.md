# RPM for wp-cli

This repository builds an RPM for wp-cli.

## Relevant wp-cli RPM names

- wp-cli: Legacy RPM containing wp-cli and wp_launch_check
- wp-cli0: RPM containing only wp-cli (version 0.x)
- wp-launch-check-0.x: RPM containing only wp_launch_check 0.x

The RPM filename built by this repository is:
```
wp-cli0-0.22.0-201607271418.noarch.rpm
{name }-{vers}-{iteration }.{arch}.rpm
```
The iteration number is the Circle build number for officiel builds, and a timestamp (YYYYMMDDhhmm) for locally-produced builds.
## Install Location

This rpm installs:

/opt/pantheon/wp-cli0/wp-cli.phar

## Releasing to Package Cloud

Any time a commit is merged on the master branch, then the wp-cli RPM is built and pushed up to Package Cloud in pantheon/internal-staging/fedora/#.

In the example, # is the fedora build number (19, 20, 22). Note that wp-cli is only installed on app servers, and there are no app servers on anything prior to f22; therefore, at the moment, we are only building for f22.

To release a new version of wp-cli, simply update the VERSION.txt file and commit. Run `make` to build locally. Push to master to have an official RPM built and pushed to Package Cloud staging via Circle CI.

## Provisioning wp-cli on Pantheon

Pantheon will automatically install any new RPM that is deployed to Package Cloud. This is controlled by [pantheon-cookbooks/wp-cli](https://github.com/pantheon-cookbooks/wp-cli/blob/master/recipes/default.rb).

## wp-cli RPM versioning strategy

If there is ever a wp-cli version 1.x, then we will maintain both wp-cli-0.x and wp-cli-1.x RPMs, so that legacy WordPress sites can continue to run 0.x until ready to upgrade.

If wp-cli ever releases a 0.x build that accidentally breaks backwards compatibility with old Pantheon sites, then we simply will not install that version until the bug is fixed in a future 0.x release.  If wp-cli ever makes a permanent change to the 0.x line that breaks backwards compatibility with old Pantheon sites without bumping its version up to 1.x, then we will simply need to make another RPM named something other than '-0.x' or '-1.x'.


