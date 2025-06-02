

// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract sendMoney{
    //deposit money 
    uint public moneyDeposited;
    function deposit() public payable {
        moneyDeposited += msg.value;
    }
    
    //Our Contract balance 
    //This shows how much is in the smart contract after the deposit 
    function contractBalance() public view returns (uint){
        return address(this).balance;
    }

    //withraw funds
    //firsly we withdraw all the funds to the account that interacts with the smart contract
    function withdrawFundAll()public{
        address payable to = payable(msg.sender);
        to.transfer(contractBalance());
    }

    //withdraw money to a specific address
    function withdrawToAddress(address payable to) public {
        to.transfer(contractBalance());
    }
}