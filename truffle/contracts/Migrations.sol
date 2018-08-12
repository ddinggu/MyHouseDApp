pragma solidity ^0.4.23;

contract Migrations {
  address public owner;
  uint public last_completed_migration; // 이전에 migrate된 컨트랙들을 확인하여 재배포 할 필요없도록 설정해둔다. 

  constructor() public {
    owner = msg.sender;
  }

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
