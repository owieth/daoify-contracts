// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { ERC721 } from "@oz/token/ERC721/ERC721.sol";
import { Ownable } from "@oz/access/Ownable.sol";

/// @title DAOify DAO Contract
/// @author Olivier Winkler (https://github.com/owieth)
/// @custom:security-contact xxx@gmail.com
contract DAO is ERC721, Ownable {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/

    /// @dev Explain to a developer any extra details
    error Token__Error();

    /// @dev Explain to a developer any extra details
    /// @param id a parameter just like in doxygen (must be followed by parameter name)
    error Token__ErrorWithParams(uint256 id);

    /*//////////////////////////////////////////////////////////////
                                 STRUCTS
    //////////////////////////////////////////////////////////////*/

    /// @dev Explain to a developer any extra details
    /// @param id a parameter just like in doxygen (must be followed by parameter name)
    /// @param name a parameter just like in doxygen (must be followed by parameter name)
    struct TokenStruct {
        uint256 id;
        string name;
    }

    /*//////////////////////////////////////////////////////////////
                                CONSTANTS
    //////////////////////////////////////////////////////////////*/

    /// @dev Explain to a developer any extra details
    uint256 private constant CONSTANT_NUMBER = 100;

    /*//////////////////////////////////////////////////////////////
                                IMMUTABLES
    //////////////////////////////////////////////////////////////*/

    /// @dev Explain to a developer any extra details
    uint256 private immutable i_immutableNumber = 100;

    /*//////////////////////////////////////////////////////////////
                                 STORAGE
    //////////////////////////////////////////////////////////////*/

    /// @dev Explain to a developer any extra details
    uint256 private s_nextTokenId;

    /// @dev Explain to a developer any extra details
    string private s_name;

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    /// @dev Explain to a developer any extra details
    /// @param from a parameter just like in doxygen (must be followed by parameter name)
    /// @param to a parameter just like in doxygen (must be followed by parameter name)
    /// @param id a parameter just like in doxygen (must be followed by parameter name)
    event TokenEvent(address indexed from, address indexed to, address indexed id);

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    /// @dev Explain to a developer any extra details
    modifier onlyMinter() {
        _;
    }

    /// @dev Explain to a developer any extra details
    /// @param minter a parameter just like in doxygen (must be followed by parameter name)
    modifier onlyMinterByAddress(address minter) {
        _;
    }

    /*//////////////////////////////////////////////////////////////
                               CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address initialOwner) ERC721("DAOIFY DAO", "DAO") Ownable(initialOwner) { }

    /*//////////////////////////////////////////////////////////////
                               EXTERNAL
    //////////////////////////////////////////////////////////////*/

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    /// @param _to a parameter just like in doxygen (must be followed by parameter name)
    function safeMint(address _to, string memory _name) external {
        uint256 _tokenId = ++s_nextTokenId;
        s_name = _name;
        _mint(_to, _tokenId);
    }

    /*//////////////////////////////////////////////////////////////
                               PUBLIC
    //////////////////////////////////////////////////////////////*/

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function getName() public view returns (string memory) {
        return s_name;
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function incrementNumber() public {
        s_nextTokenId++;
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function getCurrentNumber() public view returns (uint256) {
        return s_nextTokenId;
    }

    /*//////////////////////////////////////////////////////////////
                               INTERNAL
    //////////////////////////////////////////////////////////////*/

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function _calculateNumber() internal { }

    /*//////////////////////////////////////////////////////////////
                               PRIVATE
    //////////////////////////////////////////////////////////////*/

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function _calculateAmount() private { }
}
