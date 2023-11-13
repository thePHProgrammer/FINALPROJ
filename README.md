# DegenToken

## Overview

The `DegenToken` contract is an ERC20-compliant token written in Solidity. It extends the OpenZeppelin `ERC20` and `Ownable` contracts, providing functionalities for creating, burning, transferring tokens, and redeeming NFT accessories. The contract also includes a mapping to store NFT accessories along with their names and prices.

## Contract Details

### Functions

#### `constructor()`

- Description: Initializes the contract with the name "Degen," symbol "DGN," and mints an initial supply of 0 tokens to the contract deployer. Additionally, it stores four NFT accessories with their respective names and prices.
- Modifiers:
  - None

#### `storeNftAccessory(uint256 itemId, string memory itemName, uint256 itemPrice)`

- Description: Allows the owner to store NFT accessories with unique IDs, names, and prices.
- Parameters:
  - `itemId` (uint256): The ID of the NFT accessory.
  - `itemName` (string): The name of the NFT accessory.
  - `itemPrice` (uint256): The price of the NFT accessory.
- Modifiers:
  - `onlyOwner`: Ensures that only the owner of the contract can call this function.

#### `mint(address to, uint256 amount)`

- Description: Allows the owner to mint (create) new tokens and assign them to a specific address.
- Parameters:
  - `to` (address): The address to which the new tokens will be assigned.
  - `amount` (uint256): The amount of tokens to mint.
- Modifiers:
  - `onlyOwner`: Ensures that only the owner of the contract can call this function.
- Emits:
  - `Mint(address indexed to, uint256 value)`: Event indicating the minting action.

#### `burn(uint256 amount)`

- Description: Allows any user to burn (destroy) a specific amount of tokens.
- Parameters:
  - `amount` (uint256): The amount of tokens to burn.
- Modifiers:
  - None
- Emits:
  - `Burn(address indexed from, uint256 value)`: Event indicating the burning action.

#### `transfer(address _to, uint256 _value)`

- Description: Overrides the standard `transfer` function to add flexibility and custom functionality.
- Parameters:
  - `_to` (address): The address to which the tokens will be transferred.
  - `_value` (uint256): The amount of tokens to transfer.
- Returns:
  - `success` (bool): Indicating whether the transfer was successful.
- Modifiers:
  - None

#### `redeem(uint256 accId)`

- Description: Allows users to redeem NFT accessories using their token balance.
- Parameters:
  - `accId` (uint256): The ID of the NFT accessory to redeem.
- Returns:
  - `itemName` (string): The name of the redeemed NFT accessory.
- Revert Conditions:
  - Invalid NFT accessory ID.
  - Insufficient balance for the redemption.
- Emits:
  - `Redeem(address indexed from, string itemName)`: Event indicating the redemption action.
