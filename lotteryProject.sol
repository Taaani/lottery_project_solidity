// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// contract start
contract lottery{
    address public manger;
    address  payable[] public participants;
    constructor(){
        // when anyone deploy this contract then he will be a manager
           manger = msg.sender;
    }
    // received function only write by one time in contract and its recieve ether in the contract because we add payable word
    // external means this funtion call by everywhere except  within 
    receive() external payable{
       require(msg.value == 1 ether);
       participants.push(payable(msg.sender));
    }
    function getBlance() public view returns(uint){
        require(msg.sender == manger);
        return address(this).balance;

    }
    // function that generate a random number
    function rendom() public view returns(uint){
      return uint ( keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants.length)));
    }
    // function that select  a rondom  winner
    function selectWinner() public{
        // require manger because he annouced the winner only
      require(msg.sender == manger);
    //   minmum participant is 4 
      require(participants.length >= 2);
    //   access the rendom number
      uint getRendom = rendom();
    //   get mode with of rendom number with particpents length
      uint index = getRendom % participants.length;
      address payable winner;
      winner = participants[index];
    //   return winner;
    winner.transfer(getBlance());
    participants = new address payable[](0);

    // 0xbbc3f238411179113c62204b646b889631b046ec
      

    }
}