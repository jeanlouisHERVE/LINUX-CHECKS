#!/usr/bin/env bats

##installation 
#git clone https://github.com/bats-core/bats-core.git
#cd bats-core
#./install.sh /usr/local

# Test script 1
@test "diskspace_total" {
  run -127 diskspace_total.sh
  [ "$status" -eq 0 ]
}
