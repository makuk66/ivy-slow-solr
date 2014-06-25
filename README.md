ivy-slow-solr
=============

test case for ivy resolution failing or being very slow.

Possibly related to https://issues.apache.org/jira/browse/IVY-1465

To run: bash build-all.sh

Sample output is in the ./output directory.

The results show:

- ivy-2.3.0.jar succeeds, in 3 minutes
- ivy-2.4.0-rc1.jar fails, with "not found"
- org.apache.ivy_2.5.0.alpha_20140618062334.jar hangs when target "ivy-resolve-test" is looking for org.apache.solr#solr-parent;4.8.1
  See 2014-06-25T12:02:15Z [L3026](https://github.com/makuk66/ivy-slow-solr/blob/master/output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140618062334.txt#L3026) and 2014-06-25T12:39:13Z [L3043](https://github.com/makuk66/ivy-slow-solr/blob/master/output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140618062334.txt#L3043) in output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140618062334.txt
- my local build does the same. See [L3026]https://github.com/makuk66/ivy-slow-solr/blob/master/output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140623113200.txt#L3026) and [L3042](https://github.com/makuk66/ivy-slow-solr/blob/master/output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140623113200.txt#L3042)

Let me know at makuk66@gmail.com if there's something I'm doing wrong here.
