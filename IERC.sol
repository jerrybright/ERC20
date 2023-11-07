// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC20{
    function transfer(address _to, uint _amount)external returns(bool);
    function balanceOf(address _account)external view returns(uint);
}

library SafeMath{
    function add(uint a,uint b)internal pure returns(uint){
        uint c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint a, uint b)internal pure returns (uint){
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }
}

contract Token is IERC20{

    using SafeMath for uint;

    string public name;
    string public symbol;
    uint public decimals;
    uint public totalSupply;

    mapping(address => uint)public balanceOf;

    event Transfer(address indexed from,address indexed to,uint value);

    constructor(string memory _name,string memory _symbol, uint _decimals, uint _totalSupply){
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] += totalSupply;
    }

    function transfer(address _to, uint _value)external returns(bool){
        require(_to != address(0), "Invalid Address");
        require(balanceOf[msg.sender] >= _value, "Insufficient Token");
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
        }
}

