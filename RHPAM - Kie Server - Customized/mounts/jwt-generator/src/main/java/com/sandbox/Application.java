package com.sandbox;

public class Application
{
    private static void printHelp()
    {
        System.err.println(
            "\nAn Error Occurred (Visit https://jwt.io for JWT reference), Please check out the usage below"
            + "\n\nUsage: java -jar jwt-generator"
            + "\n\t[KEYSTORE_DIR]  [KEYSTORE_FILENAME]  [KEYSTORE_ALIAS]  [KEYSTORE_PASSWORD]"
            + "\n\t[SUBJECT_NAME]            [USER]                  [TOKEN_DURATION_SECONDS]"
        );
    }

    public static void main( String[] args )
    {
        if( args.length != 7 )
        {
            printHelp();
            System.exit(1);
        }

        String keystoreDir      = args[0];
        String keystoreFilename = args[1];
        String keystoreAlias    = args[2];
        String keystorePassword = args[3];

        String subjectName      = args[4];
        String user             = args[5];
        String tokenDurationStr = args[6];

        Integer tokenDuration;

        try
        {
            tokenDuration = Integer.parseInt(tokenDurationStr);
            JWTGenerator jwtGenerator = new JWTGenerator(keystoreDir, keystoreFilename, keystoreAlias, keystorePassword);

            String compactJwt = jwtGenerator.generateJWT(subjectName, user, tokenDuration);
            System.out.println(compactJwt);
            System.exit(0);
        }
        catch(Exception err)
        {
            err.printStackTrace();
            printHelp();
        }
    }
}