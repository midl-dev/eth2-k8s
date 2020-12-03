#!/bin/bash
mkdir /wallet
mkdir /wallet/direct
mkdir /wallet/direct/accounts
cat << EOF > /wallet/direct/keymanageropts.json
{
        "direct_eip_version": "EIP-2335",
        "direct_version": "2",
        "disabled_public_keys": []
}
EOF
cat << EOF > /wallet/direct/accounts/all-accounts.keystore.json
${PRYSM_KEYSTORE}
EOF
chmod -R 400 /wallet/direct/accounts/
echo "${PRYSM_KEYSTORE_PASSWORD}" > /password

if [ "$CHAIN" == "pyrmont" ]; then
    chain_param="--pyrmont"
else
    chain_param="--mainnet"
fi

eval /app/validator/validator --accept-terms-of-use \
    --beacon-rpc-provider=127.0.0.1:4000 \
    --wallet-dir=/wallet \
    --wallet-password-file=\password \
    --datadir /data \
    $chain_param
