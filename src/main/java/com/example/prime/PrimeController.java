package com.example.prime;

import com.example.prime.service.PrimeNumberService;
import com.example.prime.util.Jabberwocky;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.ApplicationContext;

import java.util.List;
import java.util.Arrays;

/**
 * REST Controller which serves as an entry-point for requests for prime number information.
 *
 * @author Brendt Lucas
 */
@SpringBootApplication
@RestController
@EnableAutoConfiguration
@RequestMapping("/primes")
@ComponentScan("com.example.prime")
public class PrimeController {

    @Autowired
    Jabberwocky j;

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
     * @param number The number to check if prime
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

    @RequestMapping(method = RequestMethod.GET, path = "/jibber")
    ResponseEntity<String> jibber() {
        return ResponseEntity.ok(j.generate());
    }

    public static void main(String[] args) {
        SpringApplication.run(PrimeController.class, args);
    }

    @Bean
    public CommandLineRunner commandLineRunner(ApplicationContext ctx) {
        return args -> {
            System.out.println("Let's inspect the beans provided by Spring Boot:");
            String[] beanNames = ctx.getBeanDefinitionNames();
            Arrays.sort(beanNames);
            for (String beanName : beanNames) {
                System.out.println(beanName);
            }

        };
    }

}
