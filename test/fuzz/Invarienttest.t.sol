//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.28;
import {Amm} from "src/Amm.sol";
import {Test} from "lib/forge-std/src/Test.sol";
import{StdInvariant} from "lib/forge-std/src/StdInvariant.sol";
import{Handler} from "./Handler.t.sol";
contract Invarienttestamm is StdInvariant,Test{
    Amm amm;
    Handler handler;
function setUp()public{
amm=new Amm();
handler = new Handler(amm);
targetContract(address(handler));
}
function invariant_productconstant()public{
 uint256 supply1=amm.gettokensupply(amm.gettoken1());
uint256 supply2=amm.gettokensupply(amm.gettoken2());
uint256 productexpect = supply1*supply2;
uint256 intialsupply1= 100000 ether;
uint256 intialsupply2= 100000 ether;
uint256 productactual = intialsupply1*intialsupply2;
// Allow small error (0.0001%)
    uint256 tolerance = productexpect / 1000000; // 0.0001% tolerance
    assertApproxEqAbs(productactual, productexpect, tolerance, "x * y = k should remain constant");
}
}