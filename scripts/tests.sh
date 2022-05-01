#!/usr/bin/env bash

set -eu

DOCKER_CMD="docker run --rm -i caseyw/zq:latest"

function run_test {
    if [[ "$1" != "$2" ]]; then
      echo "FAIL: Found: $1 - Expected: $2"
      exit 1
    fi
}

s1=$(echo '"hello, world"' | $DOCKER_CMD -z -)
s2='"hello, world"'
run_test "$s1" "$s2"

s1=$(echo '1 2 3' | $DOCKER_CMD -j 'sum(this)' - -)
s2='{"sum":6}'
run_test "$s1" "$s2"

s1=$(echo '{"x":2}{"x":3}{"x":4}' | $DOCKER_CMD -j 'sum(x)' -)
s2='{"sum":9}'
run_test "$s1" "$s2"

s1=$(echo '[3,4,5]' | $DOCKER_CMD -j 'over this | sum(this)' -)
s2='{"sum":12}'
run_test "$s1" "$s2"

echo "PASS"
