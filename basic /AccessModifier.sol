pragma solidity ^0.4.23;

// 함수 접근 제어자 

// 1. external
contract MyContract {
    uint external count; // 상태변수에서는 external이 사용 불가능하다.

    constructor() public{

    }

    function numOfStudents(address_teacher) public view returns(uint){
        test(); // 같은 컨트랙의 내부 함수에서는 사용 불가능
    }

    function test() external{ // test함수를 external로 선언

    }
}

contract YourContract{
    MyContract myContract; // myContract을 선언

    function callTest() public{
        myContract.test();  // 외부 컨트랙에서만 사용 가능
    }
}

// 2. internal 

contract MyContract { 
    uint count; // 상태변수는 default로 internal을 선언

    constructor() public{

    }

    function numOfStudents(address_teacher) public view returns(uint){
        test(); // 동일 컨트랙 내의 함수에서 사용이 가능
    }

    function test() internal{ // test 함수를 internal로 선언

    }
}

contract YourContract is MyContract { // 자식 is 부모 : 부모의 특징을 자식에게 상속한다.
    function callTest() public{
        test(); // MyContract로 상속받아서 test 함수를 사용 가능 
    }
}

// 3. public

contract MyContract {
    uint public count; // 상태변수를 public으로 선언

    constructor() public{

    }

    function numOfStudents(address_teacher) public view returns(uint){
        test();
    }

    function test() public{ // 함수를 public으로 선언

    }
}

contract YourContract is MyContract {
    function callTest() public{
        test();   // 상속받은 컨트랙에서도 사용 가능
    }
}

contract HisContract {
    MyContract myContract;

    function callTest() public {
        myContract.test(); // 외부 컨트랙에서도 역시 사용가능
    }
}

// 4. 

contract MyContract {
    uint public count;

    constructor() public{

    }

    function numOfStudents(address_teacher) public view returns(uint){
        test(); // 내부 컨트랙에서만 사용 가능
    }

    function test() private{

    }
}

contract YourContract is MyContract {
    function callTest() public{
        test(); // 상속받은 컨트랙에서 사용불가능
    }
}

contract HisContract {
    MyContract myContract;

    function callTest() public {
        myContract.test(); // 외부 컨트랙에서도 역시 사용불가능
    }
}