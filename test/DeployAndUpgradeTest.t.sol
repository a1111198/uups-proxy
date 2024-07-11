// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployScript.s.sol";
import {UpgradeBox} from "../script/UpgradeScript.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is Test {
    BoxV1 boxV1;
    BoxV2 boxV2;
    DeployBox deployBox;
    UpgradeBox upgradeBox;

    address proxyAddress;
    address ownerAddress = makeAddr("owner");

    function setUp() external {
        deployBox = new DeployBox();
        upgradeBox = new UpgradeBox();
        vm.stopPrank();
    }

    function testIfAfterUpgradeSameProxyAddress() public {
        proxyAddress = deployBox.deployv1();
        //Act
        boxV2 = new BoxV2();
        vm.prank(BoxV1(proxyAddress).owner());
        console.log(msg.sender);
        BoxV1(proxyAddress).transferOwnership(msg.sender);
        address v2 = address(boxV2);
        upgradeBox.upgradeTo(proxyAddress, v2);
        // assert
        uint256 expectedVersion = 2;
        assertEq(expectedVersion, BoxV2(proxyAddress).getVersion());
    }
}
