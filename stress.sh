#!/usr/bin/env bash

hey -z 20m http://localhost:8085/primes?upperBound=99999 &
hey -z 20m http://localhost:8086/primes?upperBound=99999 &
hey -z 20m http://localhost:8087/primes?upperBound=99999 &
hey -z 20m http://localhost:8088/primes?upperBound=99999 &
hey -z 20m http://localhost:8089/primes?upperBound=99999 &
hey -z 20m http://localhost:8090/primes?upperBound=99999 &
