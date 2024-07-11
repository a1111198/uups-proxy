// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployBox is Script {
    function run() external returns (address) {
        return deployv1();
    }

    function deployv1() public returns (address) {
        vm.startBroadcast();
        BoxV1 boxV1 = new BoxV1();
        ERC1967Proxy erc1967Proxy = new ERC1967Proxy(address(boxV1), "");
         vm.stopBroadcast();
        return address(erc1967Proxy);
    }
}
