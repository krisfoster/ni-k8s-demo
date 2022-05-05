#!/usr/bin/env bash
# Profile
./target/prime -XX:ProfilesDumpFile=./primes.iprof &

hey -z 1m http://localhost:8080/primes &
hey -z 1m http://localhost:8080/primes/jibber &

