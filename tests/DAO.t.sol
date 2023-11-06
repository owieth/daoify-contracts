// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import { Test } from "@std/Test.sol";
import { DAO } from "../src/DAO.sol";

/// @title Test for {Token}
/// @author Olivier Winkler (https://github.com/owieth)
/// @custom:security-contact xxx@gmail.com
contract TokenTest is Test {
    DAO public token;

    function setUp() public {
        token = new DAO(msg.sender);
    }

    function testIncrement() public {
        token.incrementNumber();
        assertEq(token.getCurrentNumber(), 1);
    }
}
