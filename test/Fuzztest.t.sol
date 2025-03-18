//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.28;
import {Amm} from "src/Amm.sol";
import {Token1} from "src/Token.sol";
import {Token2} from "src/Token.sol";
import {Test} from "lib/forge-std/src/Test.sol";
contract Fuzztest is Test{
    Amm amm;
    function setUp()public{
        amm = new Amm();
    }
    function testswap(uint256 amount)public{
        vm.assume(amount >0 && amount<1e36);
 uint256 intialsupply1= amm.gettokensupply(amm.gettoken1());
uint256 intialsupply2= amm.gettokensupply(amm.gettoken1());
uint256 productactual = intialsupply1*intialsupply2;
vm.assume(amount>0 && amount <1e36);
address token1 = amm.gettoken1();
amm.main(token1, amount);
uint256 finalsupply1 = amm.gettokensupply(amm.gettoken1());
uint256 finalsupply2 = amm.gettokensupply(amm.gettoken2());
uint256 productexpected = finalsupply1*finalsupply2;
// Allow small error (0.0001%)
    uint256 tolerance = productexpected / 1000000; // 0.0001% tolerance
    assertApproxEqAbs(productactual, productexpected, tolerance, "x * y = k should remain constant");
}

}