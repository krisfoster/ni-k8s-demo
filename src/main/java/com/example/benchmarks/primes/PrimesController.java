package com.example.benchmarks.primes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/primes")
public class PrimesController {

    @Autowired
    private PrimeNumberService primeNumberService;

    /**
     * API Operation that returns a list of prime numbers from 2 to the upperBound (inclusive)
     *
     * @param upperBound The inclusive upper bound to limit the size of the returned primes
     * @return a list of prime numbers from 2 to the upperBound (inclusive)
     */
    @RequestMapping
    List<Integer> primes(@RequestParam(value = "upperBound", defaultValue = "20") int upperBound) {
        return primeNumberService.getPrimes(upperBound);
    }

    /**
     * API Operation that determines if the number (resource) supplied is prime.
     *
     * @param number    The number to check if prime
     * @param algorithm The algorithm to use. Defaults to Sieve
     * @return {@code 200} if the number is prime, else {@code 404}
     */
    @RequestMapping(value = "/{number}")
    ResponseEntity prime(@PathVariable int number,
                         @RequestParam(value = "algorithm", required = false, defaultValue = "1") int algorithm) {

        boolean isPrime;
        switch (algorithm) {
            case 2:
                isPrime = primeNumberService.isPrimeFastLoop(number);
                break;
            case 3:
                isPrime = primeNumberService.isPrime(number);
                break;
            default:
                isPrime = primeNumberService.isPrimeSieve(number);
        }

        if (isPrime) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
