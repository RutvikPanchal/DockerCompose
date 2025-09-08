# ARTIFACT_ID = $(params.artifact-id)
# GROUP_ID = $(params.group-id)
# APICURIO_URL = $(params.apicurio-url)
OAS_FILE="./sample.yaml"
GROUP_ID="Sandbox"
REGISTRY_URL="https://apicurio-registry-rutvik-panchal-dev.apps.rm2.thpm.p1.openshiftapps.com"

if [[ -f "$OAS_FILE" ]]; then
    echo "Installing dependencies..."
else
    echo "File does not exist: $OAS_FILE"
    exit 1
fi
# dnf install -y jq > /dev/null
# dnf install -y yq > /dev/null

# Detect file type (JSON or YAML)
EXT="${OAS_FILE##*.}"

# Extract fields
if [[ "$EXT" == "json" ]]; then
  NAME=$(jq -r '.info.title' "$OAS_FILE")
  ARTIFACT_ID=$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')
  VERSION=$(jq -r '.info.version' "$OAS_FILE")
  DESCRIPTION=$(jq -r '.info.description | select(. != "") // "No description"' "$OAS_FILE")
  FILE_JSON=$(jq -S . ${OAS_FILE})
  FILE_JSON_ESCAPED=$(jq -Rs . < "$OAS_FILE")
else
  NAME=$(yq -r '.info.title' "$OAS_FILE")
  ARTIFACT_ID=$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')
  VERSION=$(yq -r '.info.version' "$OAS_FILE")
  DESCRIPTION=$(yq -r '.info.description | select(. != "") // "No description"' "$OAS_FILE")
  FILE_JSON=$(yq -o=json '.' "$OAS_FILE" | jq -S .)
  FILE_JSON_ESCAPED=$(yq -o=json '.' "$OAS_FILE" | jq -Rs .)
fi

echo ""
echo "Uploading API Spec:"
echo "  GroupId     : $GROUP_ID"
echo "  ArtifactId  : $ARTIFACT_ID"
echo "  Name        : $NAME"
echo "  Version     : $VERSION"
echo "  Description : $DESCRIPTION"

# 1.) Try to Create an Artifact
echo ""
echo "Step 1.) Try to Create an Artifact..."
REGISTRY_URL=${REGISTRY_URL}/apis/registry/v2/groups/${GROUP_ID}/artifacts
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
    -H "Content-Type: application/json" \
    -H "X-Registry-ArtifactType: OPENAPI" \
    -H "X-Registry-ArtifactId: ${ARTIFACT_ID}" \
    -H "X-Registry-Version: ${VERSION}" \
    -H "X-Registry-Name: ${NAME}" \
    -H "X-Registry-Description: ${DESCRIPTION}" \
    -d "${FILE_JSON}" "${REGISTRY_URL}")
BODY=$(echo "$RESPONSE" | sed '$d')
STATUS=$(echo "$RESPONSE" | tail -n1)
echo "Response Code: ${STATUS}"
echo "Response Body: ${BODY}"

# 2.) Artifact already exists
if [[ "$STATUS" == "409" ]]; then
    echo ""
    echo "Step 2.) Creating a new version: ${VERSION}..."
    VERSION_URL=${REGISTRY_URL}/${ARTIFACT_ID}/versions
    RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
        -H "X-Registry-Version: ${VERSION}" \
        -H "X-Registry-Name: ${NAME}" \
        -H "X-Registry-Description: ${DESCRIPTION}" \
        -d "${FILE_JSON}" "${VERSION_URL}")
    BODY=$(echo "$RESPONSE" | sed '$d')
    STATUS=$(echo "$RESPONSE" | tail -n1)
    echo "Response Code: ${STATUS}"
    echo "Response Body: ${BODY}"

    if [[ "$STATUS" == "200" ]]; then

        PAYLOAD=$(jq -n \
        --arg name "$NAME" \
        --arg description "$DESCRIPTION" \
            '{
                name: $name,
                description: $description
            }'
        )

        echo ""
        echo "Step 3.) Updating Artifact Metadata..."
        METADATA_URL=${REGISTRY_URL}/${ARTIFACT_ID}/meta
        RESPONSE=$(curl -s -w "\n%{http_code}" -X PUT -H "Content-Type: application/json" -d "${PAYLOAD}" "${METADATA_URL}")
        BODY=$(echo "$RESPONSE" | sed '$d')
        STATUS=$(echo "$RESPONSE" | tail -n1)
        echo "Response Code: ${STATUS}"
    fi
fi

if [[ "$STATUS" -ne "200" && "$STATUS" -ne "204" ]]; then
    echo ""
    echo "ERROR: ${BODY}"
    exit 1
fi