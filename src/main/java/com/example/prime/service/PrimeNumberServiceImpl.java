package com.example.prime.service;

import com.example.prime.util.PrimeNumberUtil;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * @author Brendt Lucas
 */
@Service
public class PrimeNumberServiceImpl implements PrimeNumberService {

    @Override
    public boolean isPrime(int n) {
        return PrimeNumberUtil.isPrimeByOdds(n);
    }

    @Override
    public boolean isPrimeSieve(int n) {
        return PrimeNumberUtil.isPrimeBySieve(n);
    }

    @Override
    public boolean isPrimeFastLoop(int n) {
        return PrimeNumberUtil.isPrimeByOddsExcludingMultiplesOfThree(n);
    }

    @Override
    public List<Integer> getPrimes(int upperBound) {
        if (upperBound < 2) {
            return Collections.emptyList();
        }

        // Naive example using Java 8 Stream API and multi-threading using parallel.
        // Could have more thread control using ForkJoinPool directly
        return IntStream.rangeClosed(2, upperBound).parallel()
                .filter(this::isPrimeSieve)
                .boxed()
                .collect(Collectors.toList());
    }
}
