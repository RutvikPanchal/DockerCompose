package org.custom.process;

import org.custom.util.RestUtil;

import javax.ws.rs.Consumes;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Variant;

import org.kie.server.api.marshalling.MarshallingFormat;
import org.kie.server.services.api.KieServerRegistry;
import org.kie.server.services.drools.RulesExecutionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

// Custom base endpoint:
@Api(value = "Custom Endpoints")
@Path("server/containers/instances/{containerId}/ksession")
public class CustomResource {

    private static final Logger     logger = LoggerFactory.getLogger(CustomResource.class);

    private RulesExecutionService   rulesExecutionService;
    private KieServerRegistry       registry;

    public CustomResource() {}

    public CustomResource(RulesExecutionService rulesExecutionService, KieServerRegistry registry) {
        this.rulesExecutionService = rulesExecutionService;
        this.registry = registry;
        
        logger.debug("rulesExecutionService: {}", this.rulesExecutionService);
        logger.debug("registry: {}", this.registry);
    }

    // Supported HTTP method, path parameters, and data formats:
    @POST
    @Path("/{ksessionId}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    @ApiOperation(value = "Start a new Process instance", response = Long.class, code = 201)
    @ApiResponses(value = {
        @ApiResponse(code = 201, response = Long.class, message = "Process instantiated")
    })
    public Response insertFireReturn(
        @Context HttpHeaders headers,
        @ApiParam(value = "Container Id", required = true) @PathParam("containerId") @DefaultValue(value = "sample_1.0.0")     String id,
        @ApiParam(value = "KSession Id", required = true)  @PathParam("ksessionId")  @DefaultValue(value = "default-ksession") String ksessionId,
        String cmdPayload
    ){
        Variant v = RestUtil.getVariant(headers);
        String contentType = RestUtil.getContentType(headers);

        // Marshalling behavior and supported actions:
        MarshallingFormat format = MarshallingFormat.fromType(contentType);
        if (format == null) {
            format = MarshallingFormat.valueOf(contentType);
        }
        try {
            // Add any custom code here and modify the response string
            String response = "Kie Server Extension Custom Endpoint";
            
            return RestUtil.createResponse(response, v, Response.Status.OK);
        } catch (Exception e) {
            // If marshalling fails, return the `call-container` response to maintain backward compatibility:
            String response = "Execution failed with error : " + e.getMessage();
            logger.error("Returning Failure response with content '{}'", response);
            
            return RestUtil.createResponse(response, v, Response.Status.INTERNAL_SERVER_ERROR);
        }
    }
}