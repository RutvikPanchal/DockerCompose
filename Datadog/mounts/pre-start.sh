#!/bin/sh

echo "Processing pre-start script..."

export DD_API_KEY="ef8ba985c3dac6212b49722522aa7e64"
sleep 2

cp /tmp/conf.yaml /tmp/conf-edit.yaml
WORD=ENDPOINT_PLACEHOLDER
REPLACEMENT=https://host.docker.internal:9443/metrics
sed -i "s|$WORD|$REPLACEMENT|" /tmp/conf-edit.yaml
cat /tmp/conf-edit.yaml
cp /tmp/conf-edit.yaml /etc/datadog-agent/conf.d/openmetrics.d/conf.yaml

echo "Finished pre-start script."

exec /bin/entrypoint.sh

# echo "Processing pre-start script..."
# DD_API_KEY="$(cat /run/secrets/datadog_api_key 2>/dev/null || true)"
# export DD_API_KEY=${DD_API_KEY}

# Escape &, /, and \ so sed treats them literally
# escape_sed() {
#     printf '%s' "$1" | sed 's/[&/\]/\\&/g'
# }

# PASSWORD_QA=$(escape_sed "$PASSWORD_QA")
# PASSWORD_STG=$(escape_sed "$PASSWORD_STG")
# PASSWORD_PROD=$(escape_sed "$PASSWORD_PROD")

# cp /tmp/conf.yaml /tmp/conf-edit.yaml
# PASSWORD_QA="$(cat /run/secrets/password_qa 2>/dev/null || true)"
# PASSWORD_STG="$(cat /run/secrets/password_stg 2>/dev/null || true)"
# PASSWORD_PROD="$(cat /run/secrets/password_prod 2>/dev/null || true)"
# sed -i \
#     -e "s|PASSWORD_QA|$PASSWORD_QA|" \
#     -e "s|PASSWORD_STG|$PASSWORD_STG|" \
#     -e "s|PASSWORD_PROD|$PASSWORD_PROD|" \
#     /tmp/conf-edit.yaml
# cp /tmp/conf-edit.yaml /etc/datadog-agent/conf.d/openmetrics.d/conf.yaml