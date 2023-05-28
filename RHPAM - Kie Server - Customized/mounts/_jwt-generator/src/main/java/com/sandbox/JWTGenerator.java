package com.sandbox;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.security.Key;
import java.security.KeyStore;

import java.util.Date;
import java.io.FileInputStream;

public class JWTGenerator
{
    private Key    key;
    private String alias;
    
    public JWTGenerator(String keystoreDir, String keystoreName, String keystoreAlias, String keystorePassword) throws Exception
    {
        alias               = keystoreAlias;

        String keystorePath = keystoreDir.endsWith("/") ? (keystoreDir + keystoreName) : (keystoreDir + "/" + keystoreName);
        FileInputStream is  = new FileInputStream(keystorePath);

        KeyStore keystore   = KeyStore.getInstance(KeyStore.getDefaultType());
        keystore.load(is, keystorePassword.toCharArray());

        key = keystore.getKey(keystoreAlias, keystorePassword.toCharArray());
    }

    public String generateJWT(String subjectName, String user, Integer tokenDuration)
    {
        String jwt = Jwts.builder()
                        .setHeaderParam("kid", alias)
                        .claim("user", user)
                        .setSubject(subjectName)
                        .setNotBefore(new Date())
                        .setExpiration(new Date(System.currentTimeMillis() + (tokenDuration * 1000)))
                        .signWith(key, SignatureAlgorithm.RS256)
                        .compact();
        return jwt;
    }
}