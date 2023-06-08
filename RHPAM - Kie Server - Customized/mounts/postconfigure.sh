#!/bin/sh
echo "running postconfigure.sh"
/opt/eap/bin/jboss-cli.sh --file=/opt/eap/extensions/jboss-cli-actions.sh
echo "completed postconfigure.sh"