pragma solidity ^0.4.23; // 솔리디티 컴파일러 버젼 설정

contract MyContract {
    uint[] myArray;
    uint8[3] d = [1, 2, 3]; 상태변수로 리터럴을 쓰면 memory에 위치 하지 않아도 된다.

    function learnArrays() public{
        uint256[] memory a = new uint256[](5); // new 키워드로 배열의 사이즈를 지정할 수 있다.
        bytes32[] memory b = new bytes32[](10); // memory는 이후에 사이즈를 변경할 수 없으므로 미리 설정해줘야 한다. 

        a[0] = 1;
        a[1] = 2;

        uint8[3] memory c = [1, 2, 3]; // 함수안에서 리터럴을 통해 배열 초기화할 때의 저장위치는 memory
        uint8[3] d = [1, 2, 3]; // 리터럴을 통해서 초기화 하는데, 저장위치 memory를 설정해 주지 않아서 에러가 뜬다.

        myArray.push(5); // 정적인 배열이 아닌 동적인 배열에는 push 맴버를 사용해서  상태변수 myArray 배열에 push 맴버를 써서 배열 끝에 숫자 5를 저장( push 맴버는 memory에 사용 불가능!!! storage만 사용 가능)
        uint myArrayLength = myArray.length; // length 맴버를 써서 myArray배열의 길이를 확인 -->                    myArrayLength 값 = 1 ( length는 memory, storage 상관 X )
    }
}
