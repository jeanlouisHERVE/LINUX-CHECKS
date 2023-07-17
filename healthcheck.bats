#!/usr/bin/env bats

# Require minimum BATS_VERSION 1.5.0
bats_require_minimum_version 1.5.0

##installation 
#git clone https://github.com/bats-core/bats-core.git
#cd bats-core
#./install.sh /usr/local

##TO DO 
#add alias to run healthcheck

# Test script 1
@test "diskspace_total" {
  run ./check_diskspace_total.sh
  echo "$status"
  [ "$status" -eq 0 ]
}

@test "memory" {
  run ./check_memory.sh
  echo "$status"
  [ "$status" -eq 0 ]
}
