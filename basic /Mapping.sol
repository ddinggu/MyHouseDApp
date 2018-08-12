pragma solidity ^0.4.23; // 솔리디티 컴파일러 버젼 설정

contract MyContract4 {
    mapping(address => uint256) balance; // 상태변수 balance를 맵핑해서 생성( key : address / value : uint256 )

    function learnMapping() public{
    balance[msg.sender] = 100; // key값의 value 값을 설정
    balance[msg.sender] += 100;

    uint256 currentBalance = balance[msg.sender];
    // 맵핑된 벨류값이 리턴되며, value값이 uint256이므로 동일하게 설정해줘야한다.
    }
}

contract MyContract5 {
    struct Student {
        string studentName;
        string gender;
        uint age;
    }

    mapping(uint256 => Student) studentInfo;

    function setStudentInfo(uint _studentId, string _name, string _gender, uint _age) public {
        Student storage student = studentInfo[_studentId]; // _studentId 키값으로 이루어진 특정 Student 구조체 정보를 생성한다.

// 각 필드에 인자로 받은 자료들을 대입
        student.studentName = _name;
        student.gender = _gender;
        student.age = _age;
    }

function getStudentInfo(uint256 _studentId) view public returns(string, string, uint){
                // 아직 솔리디티에서 리턴 값 매개변수를 구조체를 인자값으로 받아 올 수 없다
    // 매개변수로 받을 _studentId를 키값으로 생성된 구조체의 studentInfo값들을 불러온다.
    return (studentInfo[_studentId].studentName, studentInfo[_studentId].gender, studentInfo[_studentId].age);
    }
}