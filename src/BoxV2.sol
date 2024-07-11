// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BoxV2 is OwnableUpgradeable, UUPSUpgradeable {
    uint256 number;

    function getNumber() external view returns (uint256) {
        return number;
    }

    function setNumber(uint256 _num) external {
        number = _num;
    }

    function getVersion() external pure returns (uint256) {
        return 2;
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}
}
