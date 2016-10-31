#!/bin/sh

set -x
set -e

: ${NODE_VERSION?"must be set."}

my_dir=`dirname $0`

(
  . ${my_dir}/build_it.sh

  # We should now have access to these vars, let's share them.
  export DOCKER_IMAGE_NAME_BASE
  export DOCKER_IMAGE_NAME_BUILDDEPS
  export DOCKER_IMAGE_NAME_ONBUILD

  for meteor_version in `cat ${my_dir}/meteor_versions_to_test`; do
    ${my_dir}/tests/test_meteor_app.sh "${meteor_version}"
  done

  ${my_dir}/tests/test_bundle_local_mount.sh

  # # This uses BUNDLE_URL from S3.  Broken
  ${my_dir}/tests/test_bundle_web.sh

  ${my_dir}/tests/test_phantomjs.sh
  ${my_dir}/tests/test_no_app.sh

  # Consider doing some trap cleanup here.
)

set +x
set +e