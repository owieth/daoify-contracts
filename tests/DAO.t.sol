// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import { Test } from "@std/Test.sol";
import { DAO } from "../src/DAO.sol";

/// @title Test for {Token}
/// @author Olivier Winkler (https://github.com/owieth)
/// @custom:security-contact xxx@gmail.com
contract TokenTest is Test {
    DAO public dao;

    function setUp() public {
        dao = new DAO(msg.sender);
    }

    function test_createDAO() public {
        address _to = address(69_420);
        string memory _name = "The DAO";
        address[] memory _members = new address[](1);
        _members[0] = address(100);
        string memory _imageUri = "https://";

        dao.createDAO(_to, _name, _members, _imageUri);

        DAO.DAOStruct memory _daoStruct = dao.getDAO(1);

        assertEq(_daoStruct.tokenId, 1);
        assertEq(_daoStruct.owner, _to);
        assertEq(_daoStruct.name, _name);
        assertEq(_daoStruct.members, _members);
        assertEq(_daoStruct.imageUri, _imageUri);
    }
}
