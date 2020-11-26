#!/bin/bash
/app/beacon-chain/beacon-chain --accept-terms-of-use --http-web3provider ${ETH1_URL} \
    --rpc-host=0.0.0.0 \
    --monitoring-host=0.0.0.0 \
    --datadir /data \
    --pyrmont

