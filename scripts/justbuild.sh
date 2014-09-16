#!/bin/sh -ex
ant -Dhadoopversion=200 -Dskip-real-docs=true -Dbin.artifact.name=sqoop-${ARTIFACT_VERSION} clean tar
