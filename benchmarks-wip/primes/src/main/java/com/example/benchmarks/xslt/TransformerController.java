package com.example.benchmarks.xslt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.xml.transform.TransformerException;
import java.io.IOException;

@RestController
@RequestMapping("/transform")
public class TransformerController {
    @Autowired
    XsltTransformer transformer;

    @RequestMapping
    ResponseEntity<String> transform() throws IOException, TransformerException {
        return ResponseEntity.ok(transformer.transform());
    }
}
