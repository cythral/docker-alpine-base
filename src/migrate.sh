#!/bin/sh

set -eo pipefail

wget $MIGRATIONS_BUNDLE_URL -O ./run-migrations
chmod +x ./run-migrations

DATABASE_PASSWORD=$(decrs $ENCRYPTED_DATABASE_PASSWORD) || exit 1
CONNECTION="Server=$DATABASE_HOST"
CONNECTION="$CONNECTION;Database=$DATABASE_NAME"
CONNECTION="$CONNECTION;User=$DATABASE_USER"
CONNECTION="$CONNECTION;Password=\"$DATABASE_PASSWORD\""
CONNECTION="$CONNECTION;GuidFormat=Binary16"
CONNECTION="$CONNECTION;DefaultCommandTimeout=0"
CONNECTION="$CONNECTION;UseCompression=true"

./run-migrations --connection "$CONNECTION"