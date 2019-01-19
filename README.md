Jenkins and Apache Authentication Using Atlassian JIRA for User Management
==========================================================================

This repository contains examples for how to setup Jenkins and Apache2 to use
Atlassian Jira for authentication. The plugins its uses is designed for using
Atlassian Crowd. However, JIRA contains a minimal crowd server and it therefore
happen to work.

The same examples can also be used with Atlassian Crowd. Crowd also supports
single sign-on (SSO) which JIRA does not.

Apache Integration
------------------

At one point Atlassian wrote a plugin for Apache 2.2 to communicate with crowd.
Fortunately, they did it open source.
[Someone wrote a patch](https://bitbucket.org/atlassianlabs/cwdapache/pull-requests/18/added-apache-24-compatibility-and-fixed/diff)
to make it compatible with Apache 2.4.
Atlassian dropped support for the plugin before the pull-request was merged and
after sitting on the shelf for some time, some other person decided to pick it up and now hosts
a [working version on github!](https://github.com/fgimian/cwdapache) Thank you community!!

This repository contains a [DockerFile](apache/docker/build.DockerFile) for
constructing the build environment needed for building the plugin for Apache 2.4.
As well as a [DockerFile](apache/docker/deploy.DockerFile) for testing the
plugin bundled with Apache.

A GNU Make file defines the build system to git clone and build the plugin and
run the apache container. It expects that the system has docker, git and some other packages installed.

```shell
make run \
    APPLICATION_NAME=<your-app-name> \
    APPLICATION_PASSWORD=<your-secret-password> \
    JIRA_SERVER=<url-to-your-jira-server> \
    JIRA_GROUP=<user-group-with-access>
```

Before apache is allowed to connect with your JIRA instance, you need to
[configure JIRA](https://confluence.atlassian.com/fisheye/connecting-to-jira-for-user-management-960155582.html).

`APPLICATION_NAME` and `APPLICATION_PASSWORD` as listed for `make run` above, is
the values you specified in your JIRA application configuration.

`JIRA_SERVER` is simply the URL to your server. If your server uses HTTPS with
a self-signed certificate, include the issuing CA cert in the Apache docker
container by placing it in the [apache/certs](apache/certs) directory before
building the deployment image.

`JIRA_GROUP` is the user-group that should have access.

To stop the container, run:
```
make stop
```

For a full list of make targets run `make help`.

Also thanks to [nightprogrammer](https://www.nightprogrammer.org/administration/authenticate-apache-against-jira/) who's post pointed me in the right direction to begin with.

Jenkins Integration
-------------------

NOT IMPLEMENTED YET

Resources
---------

https://confluence.atlassian.com/fisheye/connecting-to-jira-for-user-management-960155582.html
https://github.com/fgimian/cwdapache
https://stackoverflow.com/questions/15411208/authenticate-jenkins-users-against-jira
https://wiki.jenkins.io/display/JENKINS/Crowd+2+Plugin
https://www.nightprogrammer.org/administration/authenticate-apache-against-jira/
