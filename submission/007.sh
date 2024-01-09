# Only one single output remains unspent from block 123,321. What address was it sent to?
hash=$(bitcoin-cli getblockhash 123321)
block=$(bitcoin-cli getblock $hash)

for txid in $(echo "$block" | jq -c -r '.tx[]'); do
    echo "Transaction: $txid"
    tx=$(bitcoin-cli getrawtransaction "$txid" 1)
    echo $tx | jq 
    while IFS= read -r line; do
        echo $line
        n=$(echo "$line" | jq -r '.n')
        addr=$(echo "$line" | jq -r '.scriptPubKey.address')
        echo "$n and $addr"        
    done <<< "$(echo "$tx" | jq -c '.vout[]')"
    echo ""
    # for vout in $(echo "$tx" | jq -c -r '.vout'); do
    #     echo "vout: $vout"
    # done
done

# gettxspendingprevout