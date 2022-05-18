package com.example.benchmarks.jibber;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import io.micrometer.core.annotation.Timed;

/**
 * REST Controller which serves as an entry-point for requests for jibber nonsense verse.
 *
 */
@RestController
@RequestMapping("/jibber")
public class JibberController {

    @Autowired
    Jabberwocky j;

    @RequestMapping
    @Timed(value = "method.alarms.api.getall", percentiles = { 0.5, 0.95, 0.99 }, description = "Read all alarms api metric")
    ResponseEntity<String> jibber() {
        return ResponseEntity.ok(j.generate());
    }

    @RequestMapping(value = "/{number}")
    ResponseEntity<String> jibberN(@PathVariable int number) {
        return ResponseEntity.ok(j.generate(number));
    }
}
