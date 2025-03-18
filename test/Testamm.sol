//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.28;
import {Test} from "lib/forge-std/src/Test.sol";
import {Amm} from "../src/Amm.sol";
import {Token1} from "../src/Token.sol";
import {Token2} from "../src/Token.sol";
contract Testamm is Test{
    Amm amm;
  uint256  intialsupply1=100000 ether;
 uint256 intialsupply2 =100000 ether;
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
function testcheck() public {
    uint256 supply1 = amm.gettokensupply(amm.gettoken1());
    uint256 supply2 = amm.gettokensupply(amm.gettoken2());
    uint256 actual =(intialsupply1)*(intialsupply2);
    uint256 expected =(supply1)*(supply2);
    assertEq(expected,actual);
 }
 function testcheck1()public{
    address token1 = amm.gettoken1();
    address token2 =amm.gettoken2();
    uint256 amount = 5 ether;
    uint256 intialsupply1 = amm.gettokensupply(token1);
    uint256 intialsupply2 = amm.gettokensupply(token2);
    amm.main(token1 , amount);
 uint256 finalsupply1 = amm.gettokensupply(token1);
 uint256 finalsupply2 = amm.gettokensupply(token2);
 uint256 intialproduct = (intialsupply1)*(intialsupply2);
uint256 finalproduct = (finalsupply1)*(finalsupply2);
 }
  function testcheck2()public{
    address token1 = amm.gettoken1();
    address token2 =amm.gettoken2();
    uint256 amount = 5 ether;
    uint256 intialsupply1 = amm.gettokensupply(token1);
    uint256 intialsupply2 = amm.gettokensupply(token2);
    amm.main(token2 , amount);
 uint256 finalsupply1 = amm.gettokensupply(token1);
 uint256 finalsupply2 = amm.gettokensupply(token2);
 uint256 intialproduct = (intialsupply1)*(intialsupply2);
uint256 finalproduct = (finalsupply1)*(finalsupply2);
 }
 function testcheck3()public{
      address token1 = amm.gettoken1();
    address token2 =amm.gettoken2();
     uint256 intialsupply1 = amm.gettokensupply(token1);
     uint256 intialsupply2 = amm.gettokensupply(token2);
    uint256 amount1 = 5 ether;
    uint256 amount2 =5 ether;
    uint256 expectedfinalsupply1 = amm.gettokensupply(token1) + amount1;
    uint256 expectedfinalsupply2 = amm.gettokensupply(token2) + amount2;
    amm.deposit(amount1,amount2,token2,token1);
  uint256 actualfinalsupply1 = amm.gettokensupply(token1);
 uint256 actualfinalsupply2 = amm.gettokensupply(token2);
 assertEq(expectedfinalsupply1,actualfinalsupply1);
assertEq(expectedfinalsupply2,actualfinalsupply2);
 }
 function testcheck4()public{
      address token1 = amm.gettoken1();
    address token2 =amm.gettoken2();
    uint256 amount = 5 ether;
    amm.main(token2 , amount);
    uint256 amount1 = 5 ether;
    uint256 amount2 =5 ether;
    vm.expectRevert();
    amm.deposit(amount1,amount2,token2,token1);
 }

}