// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract MarketPlace {
    struct MarketItem {
        address seller;
        uint256 price;
        uint256 tokenId;
        address nftContract;
    }

    MarketItem[] public items;
    mapping(address => uint256) public balances;

    function updatePrice(uint256 itemId, uint256 price) public {
        require(price > 0, "nonzero price");

        MarketItem storage item = items[itemId];
        require(item.seller == msg.sender, "unauthorized");

        item.price = price;
    }

    function buy(uint256 itemId) external {
        MarketItem storage item = items[itemId];
        require(balances[msg.sender] >= item.price, "insufficient balance");

        balances[msg.sender] -= item.price;
        balances[item.seller] += item.price;

        IERC1155(item.nftContract).safeTransferFrom(
            address(this),
            msg.sender,
            item.tokenId,
            1,
            ""
        );
    }

    function sell(MarketItem calldata item) external {
        require(item.seller == msg.sender, "invalid seller");

        items.push(item);

        IERC1155(item.nftContract).safeTransferFrom(
            msg.sender,
            address(this),
            item.tokenId,
            1,
            ""
        );
    }

    function depositEth() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawEth(uint256 amount) external payable {
        uint256 balance = balances[msg.sender];
        require(balance >= amount, "insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}