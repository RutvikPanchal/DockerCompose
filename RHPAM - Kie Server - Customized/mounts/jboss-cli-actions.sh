embed-server --std-out=echo --server-config=standalone-openshift.xml
batch
/subsystem=logging/logger=org.wildfly.security:add(level=ALL)
/subsystem=logging/logger=org.wildfly.elytron:add(level=ALL)
module add --name=jwt-role-decoder --resources=/opt/eap/custom/jwt-generator-1.0.0.jar --dependencies=org.slf4j,org.wildfly.security.elytron
/subsystem=elytron/custom-role-decoder=jwtDecoder:add(class-name="com.sandbox.CustomRoleDecoder", module="jwt-role-decoder")
/subsystem=elytron/key-store=jwt-key-store:add(type="JKS", path="/etc/certificate/sandbox.jks", credential-reference={clear-text="password"})
/subsystem=elytron/token-realm=jwt-realm:add(jwt={name="jwt", key-store=jwt-key-store, certificate="sandbox"}, principal-claim="sub")
/subsystem=elytron/token-realm=jwt-realm:write-attribute(name=jwt, value={key-store => jwt-key-store, certificate => "sandbox", principal-claim => "sub", "key-map" => {sandbox="-----BEGIN PUBLIC KEY-----MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwal3rzLVYXSnkuLCNw1qUIT8sVxqbWTRcHmWfsZteb+8K8280r7MNMpvb8/VeZREaO2dWCC77AdPZAHEcHhfffqXTIp6jOsk2jhnbiM2T5EB3BJpQTaLoA+akRz0b7l6PFM5s25tzxxS7jaByiZT+uiH/7hDCQ11DvA8HuDE+yjNVo1jawTy2SJZruvDG9FJfNpusyAUsk7zpTOdq8OPHVD7fZk2p6SiOSgoZUGO1Zdzm+aYqJZjqUGiC6UBkubV6PcmKyv1CPWa+JZf0m5QFHb8KdmFGRUKQU2lZt4L1VqFHJIJF6EUXHMtEsz0ckM/7VCf7m59qQsoihhvtCjU5QIDAQAB-----END PUBLIC KEY-----"}})
/subsystem=elytron/security-domain=jwt-domain:add(realms=[{realm=jwt-realm,role-decoder=jwtDecoder}], permission-mapper=default-permission-mapper, default-realm=jwt-realm)
/subsystem=elytron/http-authentication-factory=jwt-http-authentication:add(security-domain=jwt-domain, http-server-mechanism-factory=global, mechanism-configurations=[{mechanism-name="BEARER_TOKEN", mechanism-realm-configurations=[{realm-name="jwt-realm"}]}])
/subsystem=undertow/application-security-domain=other:remove
/subsystem=undertow/application-security-domain=other:add(http-authentication-factory=jwt-http-authentication)
/subsystem=ejb3/application-security-domain=other:write-attribute(name=security-domain, value=jwt-domain)
/subsystem=ejb3/application-security-domain=other:write-attribute(name=enable-jacc, value=true)
/core-service=management/management-interface=http-interface:write-attribute(name=console-enabled,value=true)
run-batch
stop-embedded-server
quit