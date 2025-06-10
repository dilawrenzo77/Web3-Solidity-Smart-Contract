// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// This is an ERC20 token that charges a fee(Tax) on every transfer.

contract taxToken is ERC20 {
    address owner;
    uint public tax = 10; 
    uint public taxCollector;
    mapping(address => uint256) _balances;

    modifier onlyOwner(){
        require(msg.sender == owner,"Not owner");
        _;
    }

    event confrimTransfer(address indexed account, uint indexed amount, string indexed message);
    event newTax(uint indexed amount, string indexed message);

    constructor() ERC20("Lawrence", "LAW") {
        owner = msg.sender;
        _mint(owner, 1000000 * 10 ** decimals());
    }

    //get balance of the tokens in any address 
    function getBalance(address _user) public view returns (uint){
        return balanceOf(_user);
    }
    
    //this function sets a tax fee for all transactions of token transfer
    //(only by the owner of the contract)
    function setTax(uint _newTax) public onlyOwner {
        tax = _newTax;
        emit newTax(_newTax,"You have Updated the tax bracket");
    }

    //tranfer tokens
    //This functionality transfers tokens to an account \
    // a specific fee(Tax) is charged by the owner of the contract
    //The fee is stored in a seperate variable that holds all the fees.
    function getToken(address _from, address _to, uint _amount) public onlyOwner {
        uint _taxPercent = (_amount * tax) / 100;
        uint _funds  = _amount - _taxPercent;
        _transfer(_from, _to, _funds);
        taxCollector += _taxPercent;
        emit confrimTransfer(_from, _funds, "token transfer");
    }
}