package com.example.benchmarks.xslt;

import io.micrometer.core.instrument.util.IOUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;
import org.yaml.snakeyaml.reader.StreamReader;

import javax.xml.transform.*;
import javax.xml.XMLConstants;
import java.io.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

@Service
@Scope("singleton")
public class XsltTransformer {

    final String xsltContent;
    final String xmlContent;
    Transformer transformer;

    public XsltTransformer() throws TransformerConfigurationException, IOException {
        // Load the xml data file and the xslt file
        InputStream xsltFile = new ClassPathResource("display.xsl").getInputStream();
        xsltContent = IOUtils.toString(xsltFile);

        InputStream xmlFile = new ClassPathResource("KBW.xml").getInputStream();
        xmlContent = IOUtils.toString(xmlFile);

        TransformerFactory tFactory = TransformerFactory.newInstance();
        tFactory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
        tFactory.setAttribute(XMLConstants.ACCESS_EXTERNAL_STYLESHEET, "");
        Source xslt = new StreamSource(new StringReader(xsltContent));
        transformer = tFactory.newTransformer(xslt);
    }

    public String transform() throws FileNotFoundException, IOException, TransformerException {
        Source xml = new StreamSource(new StringReader(xmlContent));
        ByteArrayOutputStream bytes = new ByteArrayOutputStream();
        StringWriter outXml = new StringWriter();
        Result out = new StreamResult(outXml);
        transformer.transform(xml, out);
        return outXml.toString();
    }
}