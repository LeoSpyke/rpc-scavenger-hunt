# Only one single output remains unspent from block 123,321. What address was it sent to?
hash=$(bitcoin-cli getblockhash 123321)
block=$(bitcoin-cli getblock $hash)
echo $block

for txid in $(echo "$block" | jq -c -r '.tx[]'); do
    echo "$txid"
done

# bitcoin-cli scantxoutset start '["addr()"]'