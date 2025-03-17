//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.28;
import {Test} from "lib/forge-std/src/Test.sol";
import {Amm} from "../src/Amm.sol";
import {Token1} from "../src/Token.sol";
import {Token2} from "../src/Token.sol";
contract Testamm is Test{
    Amm amm;
 uint256  intialsupply1=100000 ether;
 function setUp() public{
    amm =new Amm();  
 }
function testdeployment()external view {
assertEq(amm.s_tokensupplychange(amm.gettoken1()),100000 ether);
assertEq(amm.s_tokensupplychange(amm.gettoken2()),100000 ether);
assertEq(amm.gettoken2price(),1 ether);
assertEq(amm.gettoken1price(),1 ether);
}
function testdeposit()external {
    uint256 alpha=2 ether;
    uint256 home =1 ether;
    address token1 =makeAddr("token1");
    address token2 =makeAddr("token2");
    vm.expectRevert();
    amm.deposit(alpha,home,token2,token1);
}
function testmain()external{
    address token =makeAddr("token");
    uint256 amount =5 ;
    vm.expectRevert();
    amm.main(token,amount);
    address tokenu= amm.gettoken1();
  uint256 finalsupplyoftoken1=amount+ amm.gettokensupply(amm.gettoken1()) ;
 amm.main(tokenu,amount);
 assertEq(amm.gettokensupply(amm.gettoken1()),finalsupplyoftoken1);
 address tokenuu= amm.gettoken2();
  uint256 finalsupplyoftoken2=amount+ amm.gettokensupply(amm.gettoken2()) ;
 amm.main(tokenuu,amount);
 assertEq(amm.gettokensupply(amm.gettoken2()),finalsupplyoftoken2);
}
function testvalue1()external{
    address token =makeAddr("token");
    vm.expectRevert();
    amm.valueoftoken1(token);
    address tokenu= amm.gettoken1();
      uint256 getsupplyvalue=amm.gettokensupply( tokenu);
      uint256 expected= 1e23/getsupplyvalue;
    assertEq(amm.valueoftoken1(tokenu),expected);
}
function testvalue2()external{
    address token =makeAddr("token");
    vm.expectRevert();
    amm.valueoftoken2(token);
    address tokenu= amm.gettoken2();
    uint256 getsupplyvalue=amm.gettokensupply( tokenu);
      uint256 expected= 1e23/getsupplyvalue;
    assertEq(amm.valueoftoken2(tokenu),expected);
}
}