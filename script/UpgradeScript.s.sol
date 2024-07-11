// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {BoxV1} from "../src/BoxV1.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {
        address proxyContractAddress = DevOpsTools.get_most_recent_deployment(
            "ERC1967Proxy",
            block.chainid
        );
        //  vm.startBroadcast();
        BoxV2 boxV2 = new BoxV2();
        //   vm.stopBroadcast();
        address proxyAddres = upgradeTo(proxyContractAddress, address(boxV2));
        return proxyAddres;
    }

    function upgradeTo(
        address proxyAddres,
        address newImplementationAddress
    ) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(proxyAddres);
        proxy.upgradeToAndCall(newImplementationAddress, new bytes(0));
        vm.stopBroadcast();
        return address(proxy);
    }
}
