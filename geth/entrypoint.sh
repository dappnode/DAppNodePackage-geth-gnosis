#!/bin/sh

# shellcheck disable=SC1091
. /etc/profile

JWT_SECRET=$(get_jwt_secret_by_network "${NETWORK}")
echo "${JWT_SECRET}" >"${JWT_PATH}"

# NETWORK is always gnosis
NETWORK_FLAGS="--gnosis"

# Optionally, add any gnosis-specific flags here if needed

# Log info
echo "[INFO - entrypoint] Starting geth with network flags: $NETWORK_FLAGS"

post_jwt_to_dappmanager "${JWT_PATH}"

# shellcheck disable=SC2086
exec geth \
  --datadir "${DATA_DIR}" \
  --syncmode "${SYNCMODE:-snap}" \
  --port "${P2P_PORT}" \
  --metrics \
  --metrics.addr 0.0.0.0 \
  --authrpc.jwtsecret "${JWT_PATH}" ${NETWORK_FLAGS} ${EXTRA_OPTS}
