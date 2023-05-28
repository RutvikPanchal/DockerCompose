package com.sandbox;

import org.wildfly.security.authz.RoleDecoder;
import org.wildfly.security.authz.Roles;
import org.wildfly.security.authz.AuthorizationIdentity;

import java.util.Set;
import java.util.HashSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CustomRoleDecoder implements RoleDecoder
{
    public static Logger LOGGER = LoggerFactory.getLogger(CustomRoleDecoder.class);

    @Override
    public Roles decodeRoles(AuthorizationIdentity authorizationIdentity)
    {
        Set<String> roles = new HashSet<>();
        roles.add("user");
        roles.add("kie-server");

        return Roles.fromSet(roles);
    }   
}