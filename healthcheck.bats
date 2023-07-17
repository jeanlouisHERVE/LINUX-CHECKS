#!/usr/bin/env bats

# Require minimum BATS_VERSION 1.5.0
bats_require_minimum_version 1.5.0

##installation 
#git clone https://github.com/bats-core/bats-core.git
#cd bats-core
#./install.sh /usr/local

# Test script 1
@test "diskspace_total" {
  run ./diskspace_total.sh
  echo "$status"
  [ "$status" -eq 0 ]
}
