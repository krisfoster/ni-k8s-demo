package com.example.prime.service;

import java.util.List;

/**
 * Service for functions related to prime-number calculation
 *
 * @author Brendt Lucas
 */
public interface PrimeNumberService {

    /**
     * @see com.lucas.example.prime.util.PrimeNumberUtil#isPrimeByOdds(int)
     */
    boolean isPrime(int n);

    /**
     * @see com.lucas.example.prime.util.PrimeNumberUtil#isPrimeBySieve(int)
     */
    boolean isPrimeSieve(int n);

    /**
     * @see com.lucas.example.prime.util.PrimeNumberUtil#isPrimeByOddsExcludingMultiplesOfThree(int)
     */
    boolean isPrimeFastLoop(int n);

    /**
     * Returns a {@link List} of prime numbers given an (inclusive) upper bound
     * @param upperBound The inclusive upper bound to limit the size of the returned primes
     * @return a {@link List} of prime numbers given an (inclusive) upper bound
     */
    List<Integer> getPrimes(int upperBound);
}
