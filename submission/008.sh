# Which public key signed input 0 in this tx:
tx="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
script=$(bitcoin-cli getrawtransaction "$tx" 1 | jq -rc '.vin[0].txinwitness | last')
asm=$(bitcoin-cli decodescript $script | jq -r -c '.asm')
regex="^(OP_IF )([^ ]*)(.*)"
if [[ $asm =~ $regex ]]
then
    echo "${BASH_REMATCH[2]}"
fi
