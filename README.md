
### Deploy
forge script script/<ContractName>.s.sol:Deploy --rpc-url $SEPOLIA_RPC_URL --broadcast --private-key <PK>

### Attack
forge script script/<ContractName>.s.sol:Attack \
  --rpc-url $SEPOLIA_RPC_URL --broadcast --private-key <PK>
