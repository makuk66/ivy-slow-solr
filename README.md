ivy-slow-solr
=============

TL;DR: fixed upstream

test case for ivy resolution failing or being very slow.

Possibly related to:
- https://issues.apache.org/jira/browse/IVY-1465
- https://issues.apache.org/jira/browse/IVY-1457

To run: bash build-all.sh

Sample output is in the ./output directory, which has sub directories
for test runs, and inside has the full output.txt as well as split
output for each version.

The results show:

- ivy-2.3.0.jar succeeds, in 3 minutes
- ivy-2.4.0-rc1.jar fails, with "not found"
- org.apache.ivy_2.5.0.alpha_20140618062334.jar takes 34min resolving (not downloading) org.apache.solr#solr-parent;4.8.1
  See 2014-06-25T12:02:15Z [L3026](https://github.com/makuk66/ivy-slow-solr/blob/master/output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140618062334.txt#L3026) and 2014-06-25T12:39:13Z [L3043](https://github.com/makuk66/ivy-slow-solr/blob/master/output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140618062334.txt#L3043) in output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140618062334.txt
- my local build does the same. See [L3026](https://github.com/makuk66/ivy-slow-solr/blob/master/output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140623113200.txt#L3026) and [L3042](https://github.com/makuk66/ivy-slow-solr/blob/master/output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140623113200.txt#L3042)


Debugging
---------

I looked into what it was doing while "stuck", and determined it is in
org/apache/ivy/plugins/parser/m2/PomModuleDescriptorBuilder.java
getDependencyManagements() for the "Apache Solr parent POM"
which is [here](http://search.maven.org/remotecontent?filepath=org/apache/solr/solr-parent/4.8.1/solr-parent-4.8.1.pom).
I added some debug messages, and found it going through the extraInfos and hundreds of dependencies with hundreds of exclusions for each of the dependencies.
VisualVM profiling shows overwriteExtraInfoIfExists taking all the time.

Looking at that code I see http://svn.apache.org/viewvc/ant/ivy/core/trunk/src/java/org/apache/ivy/plugins/parser/m2/PomModuleDescriptorBuilder.java?revision=1592624&view=markup Line 621 which looks wrong. I assume it should be:

    svn diff src/java/org/apache/ivy/plugins/parser/m2/PomModuleDescriptorBuilder.java
    Index: src/java/org/apache/ivy/plugins/parser/m2/PomModuleDescriptorBuilder.java
    ===================================================================
    --- src/java/org/apache/ivy/plugins/parser/m2/PomModuleDescriptorBuilder.java	(revision 1605810)
    +++ src/java/org/apache/ivy/plugins/parser/m2/PomModuleDescriptorBuilder.java	(working copy)
    @@ -618,7 +618,7 @@
            for (ExtraInfoHolder extraInfoHolder : ivyModuleDescriptor.getExtraInfos()) {
                 if (extraInfoHolder.getName().equals(key)) {
                 extraInfoHolder.setContent(value);
    -                found = false;
    +                found = true;
                 }
             }
             if (!found) {


Fixed in https://github.com/apache/ant-ivy/commit/3076802a78f14eb1b4f23831d5a1ccec79b26554 and https://builds.apache.org/job/Ivy/490/. Thanks jeanlouisboudart!
