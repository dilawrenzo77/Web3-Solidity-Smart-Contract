// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

//This project is a simple project that creates a simple ERC20 Token 
//The token has some basic functionalites

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Lawrence is ERC20 {
    address owner;
    uint promocode = 12345;
    mapping(address => uint256)  _balances;

    //we create a modifier to ensure that the account deploying the contract is the owner of the contract
    modifier onlyOwner(){
        require(msg.sender == owner,"Not owner");
        _;
    }

    //some events to be triggered in the functions
    event transferMessage(address _to,uint256 _amount,string  _message);
    event bonusMessage(address _to,uint256 _amount,string  _message);

    
    //we initialize the token with a million Tokens to the account(address) that deployed the smart contract
    constructor() ERC20("Lawrence", "LAW") {
        owner = msg.sender;
        _mint(owner, 1000000 * 10 ** decimals());
    }

    //we created a function that allows the owner to transfer tokens to another account
    function transferToken(address _to) public onlyOwner{
        uint fee = 50 * 10 ** decimals();
        _transfer(owner,_to, fee);
        emit transferMessage(_to, fee, "A 50 Token bonus was transfered to you");
    }

    //we created function that allows other accounts to get 20 bonus token
    //if only they use a PROMO CODE
    function getToken(address _to,uint _promocode) public {
        require(_promocode == promocode, "Wrong password! you dont qualify for the free token");
        uint bonus = 20 * 10 ** decimals();
        _transfer(owner,_to,bonus);
        emit bonusMessage(_to, bonus, "A 20 Token bonus was transfered to you");
    }


    //we get the token balances of various accounts
    function getBalance(address _owner) public view returns (uint){
        return _balances[_owner];
    }
}