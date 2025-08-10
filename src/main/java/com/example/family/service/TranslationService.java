package com.example.family.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import java.util.*;

@Service
public class TranslationService {

    @Autowired
    private RestTemplate restTemplate;

    private static final String API_URL = "https://de.libretranslate.com/translate";
    private static final String DELIMITER = "|||";

    public List<String> translateNamesBatch(List<String> names, String targetLang) {
        String joinedText = String.join(DELIMITER, names);


        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("q", joinedText);
        requestBody.put("source", "en");
        requestBody.put("target", targetLang);
        requestBody.put("format", "text");

        HttpEntity<Map<String, String>> entity = new HttpEntity<>(requestBody, headers);

        try {
            ResponseEntity<Map> response = restTemplate.exchange(
                    API_URL,
                    HttpMethod.POST,
                    entity,
                    Map.class
            );

            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                String translated = (String) response.getBody().get("translatedText");
                return Arrays.asList(translated.split("\\Q" + DELIMITER + "\\E"));
            } else {
                throw new RuntimeException("Translation failed with status: " + response.getStatusCode());
            }

        } catch (Exception e) {
            e.printStackTrace();
            return names; // fallback to original names
        }
    }

}

