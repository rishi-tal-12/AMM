//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.28;
import {Amm} from "src/Amm.sol";
import {Token1} from "src/Token.sol";
import {Token2} from "src/Token.sol";
import{StdCheats} from "lib/forge-std/src/StdCheats.sol";
contract Handler is StdCheats{
 Amm amm;
 Token1 token1;
 Token2 token2;
constructor(Amm _amm){
amm=_amm;
token1 = Token1(amm.gettoken1());
token2 = Token2(amm.gettoken2());
}
function swap (address token, uint256 amount)public{
require(token == amm.gettoken1() || token == amm.gettoken2(), "Invalid token address");
require(amount > 0 && amount < 1e18, "Invalid swap amount");
amm.main(token, amount);
}
}