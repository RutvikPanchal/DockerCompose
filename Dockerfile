FROM registry.access.redhat.com/ubi9/ubi-minimal:9.6

ENV LANG=en_US.utf8

# Install jq from RHEL repos
RUN microdnf install -y jq \
    && microdnf clean all

RUN curl -L https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 \
        -o /usr/bin/yq \
    && chmod +x /usr/bin/yq

CMD ["/bin/bash"]