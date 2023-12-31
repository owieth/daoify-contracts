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
    struct DAOStruct {
        uint256 tokenId;
        address owner;
        string name;
        address[] members;
        string imageUri;
    }

    /*//////////////////////////////////////////////////////////////
                                 STORAGE
    //////////////////////////////////////////////////////////////*/

    /// @dev Explain to a developer any extra details
    uint256 private s_nextTokenId;

    /// @dev Explain to a developer any extra details
    mapping(uint256 tokenId => DAOStruct dao) private s_daos;

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    /// @dev Explain to a developer any extra details
    /// @param dao a parameter just like in doxygen (must be followed by parameter name)
    /// @param account a parameter just like in doxygen (must be followed by parameter name)
    /// @param action a parameter just like in doxygen (must be followed by parameter name)
    event ActivityEvent(uint256 indexed dao, address indexed account, string indexed action);

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    /// @dev Explain to a developer any extra details
    modifier onlyDAOOwner(uint256 _tokenId) {
        require(s_daos[_tokenId].owner == msg.sender, "NOT OWNER");
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
    function createDAO(address _to, string memory _name, address[] memory _members, string memory _imageUri) external {
        uint256 _tokenId = ++s_nextTokenId;

        DAOStruct memory _daoStruct =
            DAOStruct({ tokenId: _tokenId, owner: _to, name: _name, members: _members, imageUri: _imageUri });

        _mint(_to, _tokenId);

        s_daos[_tokenId] = _daoStruct;
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    /// @param _dao a parameter just like in doxygen (must be followed by parameter name)
    /// @param _account a parameter just like in doxygen (must be followed by parameter name)
    /// @param _action a parameter just like in doxygen (must be followed by parameter name)
    function addActivity(uint256 _dao, address _account, string memory _action) external {
        emit ActivityEvent(_dao, _account, _action);
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    /// @param _tokenId a parameter just like in doxygen (must be followed by parameter name)
    /// @param _member a parameter just like in doxygen (must be followed by parameter name)
    function addMember(uint256 _tokenId, address _member) external onlyDAOOwner(_tokenId) {
        s_daos[_tokenId].members.push(_member);
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    /// @param _tokenId a parameter just like in doxygen (must be followed by parameter name)
    /// @param _member a parameter just like in doxygen (must be followed by parameter name)
    function removeMember(uint256 _tokenId, address _member) external onlyDAOOwner(_tokenId) {
        address[] storage _members = s_daos[_tokenId].members;
        uint256 _arrayLength = _members.length;

        for (uint256 i; i < _arrayLength;) {
            if (_members[i] == _member) {
                _members[i] = _members[_arrayLength - 1];
            }

            unchecked {
                ++i;
            }
        }

        _members.pop();

        s_daos[_tokenId].members = _members;
    }

    /*//////////////////////////////////////////////////////////////
                               PUBLIC
    //////////////////////////////////////////////////////////////*/

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function getDAOs() public view returns (DAOStruct[] memory) {
        DAOStruct[] memory _daosQuery = new DAOStruct[](s_nextTokenId);

        for (uint256 i; i < s_nextTokenId;) {
            _daosQuery[i] = s_daos[i];

            unchecked {
                ++i;
            }
        }

        return _daosQuery;
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function getDAO(uint256 _tokenId) public view returns (DAOStruct memory) {
        return s_daos[_tokenId];
    }
}
