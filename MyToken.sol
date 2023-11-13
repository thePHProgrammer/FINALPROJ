// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    mapping(uint256 => Nft) public nftaccs;

    struct Nft {
        string name;
        uint256 price;
    }

    constructor() ERC20("Degen", "DGN") {
        _mint(msg.sender, 0); // Mint initial supply (0 tokens) to the contract deployer
        storeNftAccessory(0, "Pickaxe", 50);
        storeNftAccessory(1, "Sword", 100);
        storeNftAccessory(2, "Bow", 200);
        storeNftAccessory(3, "Diamond Armor", 250);
    }

    function storeNftAccessory(uint256 itemId, string memory itemName, uint256 itemPrice) public onlyOwner {
        nftaccs[itemId] = Nft(itemName, itemPrice);
    }

    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Redeem(address indexed from, string itemName);

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
        emit Mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
        emit Burn(msg.sender, amount);
    }

    function transfer(address _to, uint256 _value) public override returns (bool success) {
        _transfer(_msgSender(), _to, _value);
        return true;
    }

    function redeem(uint256 accId) external returns (string memory) {
        require(nftaccs[accId].price > 0, "Invalid item ID.");

        uint256 redemptionAmount = nftaccs[accId].price;
        require(balanceOf(msg.sender) >= redemptionAmount, "Balance should be equal to or more than the item to redeem it.");

        _burn(msg.sender, redemptionAmount);

        emit Redeem(msg.sender, nftaccs[accId].name);

        return nftaccs[accId].name;
    }
}
