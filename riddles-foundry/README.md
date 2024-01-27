## Riddles - [Foundry Version]


### Overmint 3 

- **Goal** : Must exploit within one transaction to get a balance of 5 NFTs. 

- We know that : 
```If a contract makes an external call from a constructor, then it’s apparent bytecode size will be zero because the smart contract deployment code hasn’t returned the runtime code yet```, so bypassing the contract check is done by making external calls through the constructor of the attacker address. 


### Democracy 

- **Goal** : Drain all NFTs of the contract 

- We know that : 
```The owner of the contract is the incumbent and this can change through voting. Changing storage of the challenger to the incumbent address (storage slot 3) will allow the challenger(now incumbent) to withdraw all the NFTs```

