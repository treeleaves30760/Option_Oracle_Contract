# SeikaLink Oracle
## Description
In this project, there exist two solidity file. "main.sol" is the option oracle contract, with the token address. "SeikaToken.sol" is the token contract, with erc-20.
## Function in main.sol
### setOwner
For owner to transfer the contract control permission. The owner can only set the oracle address, which is the option data provider.
### setOracleAddress
Change the data provider's address.
### checkAllowance
Check the address's SKT allowance to oracle contract
### getOptionPrice
#### parameter
1. coin: the coin's option you want to get.
2. date: the option execute date.
3. price: the option execute price.
4. buytype: Option for buy call or buy put
Before you call this function, you need to give the contract address at least 10 SKT allowances, after success calling, you will get a number, which is jobId, is the number that we get your result.
### updateOptionPrice
Only for oracle, is the function that you can provide the option data.
### getResult
With the number you get from getOptionPrice, you can get the result once it is finish.