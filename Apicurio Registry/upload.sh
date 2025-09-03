# ARTIFACT_ID = $(params.artifact-id)
# GROUP_ID = $(params.group-id)
# APICURIO_URL = $(params.apicurio-url)
OAS_FILE="./sample.yaml"
GROUP_ID="Sandbox"
REGISTRY_URL="https://apicurio-registry-rutvik-panchal-dev.apps.rm2.thpm.p1.openshiftapps.com"

echo "Installing dependencies..."
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
  CONTENT=$(jq -Rs . < "$OAS_FILE")
else
  NAME=$(yq -r '.info.title' "$OAS_FILE")
  ARTIFACT_ID=$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')
  VERSION=$(yq -r '.info.version' "$OAS_FILE")
  DESCRIPTION=$(yq -r '.info.description | select(. != "") // "No description"' "$OAS_FILE")
  CONTENT=$(yq -o=json '.' "$OAS_FILE" | jq -Rs .)
fi

echo "Uploading API Spec:"
echo "  GroupId     : $GROUP_ID"
echo "  ArtifactId  : $ARTIFACT_ID"
echo "  Name        : $NAME"
echo "  Version     : $VERSION"
echo "  Description : $DESCRIPTION"

PAYLOAD=$(jq -n \
  --arg groupId "$GROUP_ID" \
  --arg artifactId "$ARTIFACT_ID" \
  --arg version "$VERSION" \
  --arg name "$NAME" \
  --arg description "$DESCRIPTION" \
  --argjson content "$CONTENT" \
  '{
        groupId: $groupId,
        artifactId: $artifactId,
        artifactType: "OPENAPI",
        name: $name,
        description: $description,
        firstVersion: {
            version: $version,
            content: {
                content: $content,
                contentType: "application/json"
            }
        }
    }'
)

# Upload to Apicurio Registry
REGISTRY_URL=${REGISTRY_URL}/apis/registry/v3/groups/${GROUP_ID}/artifacts
echo $REGISTRY_URL

RESPONSE=$(curl -s -w "\n%{http_code}" -X POST -H "Content-Type: application/json" -d "${PAYLOAD}" "${REGISTRY_URL}")

# RESPONSE=$(curl -s -w "\n%{http_code}" -X DELETE "${REGISTRY_URL}/${ARTIFACT_ID}")

BODY=$(echo "$RESPONSE" | sed '$d')
STATUS=$(echo "$RESPONSE" | tail -n1)

echo "Response Code: ${STATUS}"
echo "Response Body: ${BODY}"