package com.example.benchmarks;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


/**
 * REST Controller which serves as an entry-point for requests for prime number information.
 *
 * @author kris.foster@oracle.com
 */
@SpringBootApplication
public class BenchmarkServerJibber {


    public static void main(String[] args) {
        SpringApplication.run(BenchmarkServerJibber.class, args);
    }
}
