pragma solidity ^0.4.23; // 솔리디티 컴파일러 버젼 설정

contract MyContract{
    uint[] ages; // storage(상태변수의 defalut 값)
                                // [11, 22, 33]
    function learnDataLocation(uint[] newAges) public returns (uint a){
        ages = newAges; // newAges 배열을 ages 배열에 복사. ages 값 : [11, 22, 33]
        uint16 myAge = 44; // 기본 값 타입(int, uint, bool, etc)은 로컬변수로 쓰일 때, memory에 저장
        uint[] studentAges = ages; // 배열은 로컬변수로 쓰일 때 storage에 저장
                                   // studentAges는 ages를 가리키는 포인터
                                   // studentAges 값 : [11, 22, 33]

        studentAges[0] = myAge; // studentAges 배열의 첫번째 인덱스를 44로 바꿈
                                // studentAges 값 : [44, 22, 33]
                                // ages 값 : [44, 22, 33]

        a = studentAges[0]; // 44를 리턴변수에 대입. a는 memory

        return a; // a는 종료되면서 값이 휘발하게 된다. 
    }
}