package org.custom;

import org.custom.process.CustomResource;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import org.kie.server.services.api.KieServerRegistry;
import org.kie.server.services.api.SupportedTransports;
import org.kie.server.services.drools.RulesExecutionService;
import org.kie.server.services.api.KieServerApplicationComponentsService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// Delivers REST endpoints to the KIE Server infrastructure that is deployed when the application starts.
public class KieServerExtension implements KieServerApplicationComponentsService {  

    // Specifies the extension that you are extending, such as the Drools extension in this example.
    private static final String OWNER_EXTENSION = "Drools";

    // Logger
    Logger logger = LoggerFactory.getLogger(KieServerExtension.class);

    // Returns all resources that the REST container must deploy.
    // Each extension that is enabled in your KIE Server instance calls the getAppComponents method,
    // so the if ( !OWNER_EXTENSION.equals(extension) ) call returns an empty collection for any extensions
    // other than the specified OWNER_EXTENSION extension.
    public Collection<Object> getAppComponents(String extension, SupportedTransports type, Object... services) {

        // Do not accept calls from extensions other than the owner extension:
        if (!OWNER_EXTENSION.equals(extension) ) {
            return Collections.emptyList();
        }

        logger.info("Registering: KieServerExtension");

        // Lists the services from the specified extension that you want to use,
        // such as the RulesExecutionService and KieServerRegistry services from the Drools extension in this example.
        RulesExecutionService rulesExecutionService = null;
        KieServerRegistry context = null;

        for( Object object : services ) {
            if( RulesExecutionService.class.isAssignableFrom(object.getClass()) ) {
                rulesExecutionService = (RulesExecutionService) object;
                continue;
            } else if( KieServerRegistry.class.isAssignableFrom(object.getClass()) ) {
                context = (KieServerRegistry) object;
                continue;
            }
        }

        logger.info("RulesExecutionService rulesExecutionService: {}", rulesExecutionService);
        logger.info("KieServerRegistry context: {}", context);

        List<Object> components = new ArrayList<Object>(1);
        if( SupportedTransports.REST.equals(type) ) {
            // Specifies the transport type for the extension,
            // either REST or JMS (REST in this example),
            // and the CustomResource class that returns the resource as part of the components list.
            components.add(new CustomResource(rulesExecutionService, context));
        }

        logger.info("Registered: KieServerExtension");

        return components;
    }
}