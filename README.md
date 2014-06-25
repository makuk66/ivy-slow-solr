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
  See 2014-06-25T12:02:15Z and 2014-06-25T12:39:13Z in output/2014-06-25T11:20:13Z/ivy-2.5.0.alpha_20140618062334.txt

Let me know at makuk66@gmail.com if there's something I'm doing wrong here.
