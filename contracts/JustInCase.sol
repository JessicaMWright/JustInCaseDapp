// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract justInCase {

    address public owner;
    address[] public dependents;
   

    constructor() {
        owner = msg.sender;
    }
        

    modifier onlyOwner {
        require(owner == msg.sender, "only owner");
        _;
    }
        
    receive() external payable {}

    function withdraw(uint256 _amount) external onlyOwner{
        
        payable(msg.sender).transfer(_amount);
    }

    function addDependent(address dependent) external onlyOwner{
        dependents.push(payable(dependent));
        
    }
    function sendToDependent() external payable onlyOwner {
        uint256 validDependentAmount = address(this).balance / dependents.length;
       for (uint i = 0; i < dependents.length; i++) {
           address payable dependent = payable(dependents[i]) ;
           payable(dependent).transfer(validDependentAmount);
       }
    
            
    }
    function checkBalance() public view returns(uint256) {
        uint256 balance = address(this).balance;
        return balance;


    }
        

}
