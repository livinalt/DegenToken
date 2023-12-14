// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "../node_modules/hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    address store = 0x5723fea1DDC24609F0150Ff0C0B96Af77ceF0753;

    event Redeem(address indexed player, uint256 amount, uint256 option);

    constructor() ERC20("Degen", "DGN") {}

    
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() override  public pure returns (uint8){
        return 0;
    }

    function getBalance() external view returns (uint256){
        return this.balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        approve(msg.sender, _value);
        transferFrom(msg.sender, _receiver, _value);
    }

    function burnTokens(uint256 _value) public payable {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        approve(msg.sender, _value);
        burnFrom(msg.sender, _value);
    }

    // Game store holding different items
    function inGameItems() external pure returns (string memory) {
        return "item 1: Ironman Shield \n Item 2: Stormbreaker \n Item 3: Unicorn";
    }

    // Redemption function using a four option category

   // Redemption function using a four category system

    function redeemTokens(uint256 _category) public {
        
        require(_category>= 1 && _category <= 4, "You have specified an invalid option");

        uint256 redeemAmount = calculateRedemptionAmount(_category);

        require(balanceOf(msg.sender) >= redeemAmount, "Insufficient Degen Tokens");

        
        _transfer(msg.sender, store, redeemAmount);

        emit Redeem(msg.sender, redeemAmount, _category);
    }

    // Calculate the redemption amount based on the category

    function calculateRedemptionAmount(uint256 _category) internal pure returns (uint256) {
        if (_category == 1) {
            return 60;
        } 
        else if (_category == 2) {
            return 30;
        } 
        else if (_category == 3) {
            return 15;
        } 
        else if (_category == 4) {
            return 5;
        } 
        else {
            revert("Option specified is not valid");
        }
    }
       
}
