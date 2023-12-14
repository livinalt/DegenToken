# Degen Gaming ERC-20 Token

# Overview
This repository contains the source code for the Degen Gaming ERC-20 token, deployed on the Avalanche network. The Degen token is designed to facilitate a reward system within the Degen Gaming platform, allowing players to earn, transfer, redeem, and burn tokens.

## Functions

### Minting New Tokens
The owner of the contract can mint new tokens, which are then distributed as rewards to players.

```solidity
function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

```

### Transferring Tokens
Players can transfer their tokens to other addresses using the transferTokens function.

```solidity

function transferTokens(address _receiver, uint _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        approve(msg.sender, _value);
        transferFrom(msg.sender, _receiver, _value);
    }

```

### Redeeming Tokens
Players can redeem their tokens for in-game items by calling the redeemTokens function.

```solidity

function redeemTokens(uint256 option) public {
        
        require(option >= 1 && option <= 4, "Invalid option");

        uint256 redeemAmount = calculateRedemptionAmount(option);

        require(balanceOf(msg.sender) >= redeemAmount, "Insufficient Degen Tokens");

        address store = 0x5723fea1DDC24609F0150Ff0C0B96Af77ceF0753;

        _transfer(msg.sender, store, redeemAmount);

        emit Redeem(msg.sender, redeemAmount, option);
        // console.log("Redemption successful. Option: %s, Amount: %s", option, redeemAmount);
    }

```

### Checking Token Balance
Players can check their token balance at any time by calling the getBalance function.

```solidity

function getBalance() external view returns (uint256){
        return this.balanceOf(msg.sender);
    }

```

### Burning Tokens
Anyone can burn tokens that they own but no longer need, using the burnTokens function.

```solidity

function burnTokens(uint256 _value) public payable {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        approve(msg.sender, _value);
        burnFrom(msg.sender, _value);
    }

```

## Tools Used
*   Computer
*   NodeJS
*   Hardhat
*   Solidity
*   Avalanche Fuji Testnet
*   Snowtrace

### Installing

* Clone this repository by using the git clone command
    ```bash

    git clone

    ```
* In your project folder run `npm init`

```bash

npm init -y

```

* Install Hardhat
```bash

npm install --save-dev hardhat

```
* Install openZeppelin to enable smart contract library for contracts development
```bash

npm install @openzeppelin/contracts

```
* Any modifications needed to be made to files/folders

### Executing program

* Run to deploy your contract
```bash
$ npx hardhat run scripts/deploy.js --network fuji
```

## Help
For help check [Guide.md] for detailed instructions 

## Authors

Jeremiah Samuel

livinalt@gmail.com
https://twitter.com/jeremiahdsamuel


## License

This project is licensed under the MIT License.
