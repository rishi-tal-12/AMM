//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.28;
import {Script} from "lib/forge-std/src/Script.sol";
import {Amm} from "../src/Amm.sol";
contract Deployamm is Script{
    Amm amm;
    function run()external returns(Amm){
    vm.startBroadcast();
    amm= new Amm();
    vm.stopBroadcast();
    return amm;
    }
}