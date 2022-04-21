package com.example.prime.util;

import java.util.Arrays;

/**
 * Utility class for prime number calculation
 *
 * @author Brendt Lucas
 */
public class PrimeNumberUtil {

    static final boolean[] sieve = new boolean[200];

    static {
        Arrays.fill(sieve, 2, sieve.length, true);

        for (int i = 2; i * i < sieve.length; i++) {
            if (sieve[i]) {
                for (int j = i * i, m = 1; j < sieve.length; j = ((i * i) + i * m++)) {
                    sieve[j] = false;
                }
            }
        }
    }

    /**
     * A method to determine if {@code n} is a prime number.
     * This method first attempts to check for simple known prime and non-prime numbers, afterward
     * it uses trial-by-division using an incrementing odd number to iterate by.
     *
     * @param n The number which shall be determined to be prime or non-prime
     * @return {@code true} if {@code n} is prime, otherwise {@code false}
     */
    public static boolean isPrimeByOdds(int n) {
        if (n <= 1) {
            // numbers less than 2 are not considered prime
            return false;
        }

        if (n <= 3) {
            // 2 and 3 are prime numbers
            return true;
        }

        if (!isOdd(n) || n % 3 == 0) {
            // even numbers ( > 2 ) and numbers that are multiples of 3 are non-prime
            return false;
        }

        // The number is odd. Is it prime?
        // Loop through all odd numbers determining if N is divisible by the odd number
        for (int i = 5; i * i <= n; i += 2) {
            if (n % i == 0) {
                return false;
            }
        }
        return true;
    }

    /**
     * A method to determine if {@code n} is a prime number.
     * This method is similar to {@link #isPrimeByOdds(int)}, but instead of incrementing by each odd number,
     * it increments by each odd number that is not a multiple of 3. This saves loop iterations.
     *
     * @param n The number which shall be determined to be prime or non-prime
     * @return {@code true} if {@code n} is prime, otherwise {@code false}
     */
    public static boolean isPrimeByOddsExcludingMultiplesOfThree(int n) {

        if (n <= 1) {
            // numbers less than 2 are not considered prime
            return false;
        }

        if (n <= 3) {
            // 2 and 3 are prime numbers
            return true;
        }

        if (!isOdd(n) || n % 3 == 0) {
            // even numbers ( > 2 ) and numbers that are multiples of 3 are non-prime
            return false;
        }

        // The number is odd. Is it prime?
        // Loop through all odd numbers (excluding those divisible by 3) determining if N is divisible by the odd number
        for (int i = 5; i * i <= n; i += 6) {
            if (n % i == 0 || n % (i + 2) == 0) {
                return false;
            }
        }
        return true;
    }

    /**
     * A method to determine if {@code n} is a prime number.
     * This method is similar to {@link #isPrimeByOddsExcludingMultiplesOfThree(int)}, but also checks a sieve which
     * contains numerous pre-calculated prime and non-prime numbers.
     *
     * @param n The number which shall be determined to be prime or non-prime
     * @return {@code true} if {@code n} is prime, otherwise {@code false}
     */
    public static boolean isPrimeBySieve(int n) {

        if (n <= 1) {
            return false;
        }

        if (n < sieve.length) {
            // n has been pre-calculated in the sieve
            return sieve[n];
        }

        if (!isOdd(n) || n % 3 == 0) {
            // even numbers ( > 2 ) and numbers that are multiples of 3 are non-prime
            return false;
        }

        // The number is odd. Is it prime?
        // Loop through all odd numbers (excluding those divisible by 3) determining if N is divisible by the odd number
        for (int i = 5; i * i <= n; i += 6) {
            if (n % i == 0 || n % (i + 2) == 0) {
                return false;
            }
        }
        return true;
    }


    static boolean isOdd(int n) {
        return (n & 1) == 1;
    }
}
