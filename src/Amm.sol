//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.28;
import {Token1} from "src/Token.sol";
import {Token2} from "src/Token.sol";
contract Amm{
    error Not_correcttoken();
    Token1 token1;
    Token2 token2;
    uint256 intialsupply1;
    uint256 intialsupply2;
    uint256 mintingsupply1;
    uint256 mintingsupply2;
    address owner;
    uint256 tokenprice1;
    uint256 tokenprice2;
    uint256 percentageofdepositer;
    uint256 percentagetopool;
    mapping (address=>uint256) public s_tokensupplychange;
    error Not_5050();
    constructor (){
        mintingsupply1=1e18 ether;
        mintingsupply2 =1e18 ether;
        intialsupply1=100000 ether;
        intialsupply2=100000 ether;
        tokenprice1 =1 ether;
        tokenprice2 =1 ether;
     token1 =new Token1(mintingsupply1) ;
     token2 =new Token2 ( mintingsupply2);
   s_tokensupplychange[address(token1)]= intialsupply1;
    s_tokensupplychange[address(token2)]= intialsupply2;
    }

 function main(address token,uint256 amount) public  returns(uint256){
    if(token != address(token1)  && token != address(token2)){
        revert Not_correcttoken();
    }
    if(token ==address(token1)){
uint256 intialsupplyoftoken1=s_tokensupplychange[address(token1)];
uint256 intialsupplyoftoken2=s_tokensupplychange[address(token2)];
uint256 finalsupplyoftoken1=amount+intialsupplyoftoken1 ;
uint256 finalsupplyoftoken2= (1e46)/finalsupplyoftoken1;
s_tokensupplychange[address(token1)]=finalsupplyoftoken1;
s_tokensupplychange[address (token2)]=finalsupplyoftoken2;
return intialsupplyoftoken2-((1e46)/finalsupplyoftoken1);
    }
     if(token ==address(token2)){
uint256 intialsupplyoftoken1=s_tokensupplychange[address(token1)];
uint256 intialsupplyoftoken2=s_tokensupplychange[address(token2)];
uint256 finalsupplyoftoken2=amount+intialsupplyoftoken2 ;
uint256 finalsupplyoftoken1= (1e46)/finalsupplyoftoken2;
s_tokensupplychange[address(token1)]=finalsupplyoftoken1;
s_tokensupplychange[address (token2)]=finalsupplyoftoken2;
return intialsupplyoftoken1-((1e46)/finalsupplyoftoken2);
    }
 }
 function valueoftoken1(address token)public view returns(uint256){
    if(token ==address(token1)){
 uint256 value1= 1e23/s_tokensupplychange[address(token1)];
 return value1;
    }else{
        revert Not_correcttoken();
    }
 }
   function valueoftoken2(address token)public view returns(uint256){
if(token ==address(token2)){
 uint256 value2= 1e23/s_tokensupplychange[address(token)];
 return value2;
}else{
     revert Not_correcttoken();
}
 }
  function deposit(uint256 amount1,uint256 amount2,address tokenn2,address tokenn1) external {
    uint256 value1= valueoftoken1(tokenn1);
    uint256 value2= valueoftoken2(tokenn2);
  //  uint256 p =amount2/amount1;
  //  uint256 q= value2/value1;
  //  if(p!=q){
  if((amount1*value2) != (amount2*value1)){
        revert Not_5050();
    }
    s_tokensupplychange[address(token1)]+=amount1;
     s_tokensupplychange[address(token2)]+=amount2;
  }

   function gettokensupply(address token) external view returns(uint256){
    return s_tokensupplychange[token];
   } 
   function gettoken1()external view returns (address){
    return address(token1);
   }
    function gettoken2()external view returns (address){
    return address(token2);
   }
   function gettoken1price()external view returns (uint256){
    return tokenprice1;
   }
 function gettoken2price()external view returns (uint256){
    return tokenprice2;
   }
}