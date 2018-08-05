pragma solidity ^0.4.24;

contract MyContract1{
    uint[] ages; // storage(상태변수의 defalut 값)
                                // [11, 22, 33]
    function learnDataLocation(uint[] newAges) public returns (uint a){
        ages = newAges; // newAges 배열을 ages 배열에 복사. ages 값 : [11, 22, 33]
        uint16 myAge = 44;  // 기본 값 타입(int, uint, bool, etc)은 로컬변수로 쓰일 때, memory에 저장
        uint[] studentAges = ages; // 배열은 로컬변수로 쓰일 때 storage에 저장
                                   // studentAges는 ages를 가리키는 포인터 
                                   // studentAges 값 : [11, 22, 33]

        studentAges[0] = myAge; // studentAges 배열의 첫번째 인덱스를 44로 바꿈
                                // studentAges 값 : [44, 22, 33]
                                // ages 값 : [44, 22, 33]

        a = studentAges[0]; // 44를 리턴변수에 대입. a는 memory

        return a;
    }
}


contract MyContract2 {
    uint[] myArray;

    function learnArrays() public{
        uint256[] memory a = new uint256[](5);
        bytes32[] memory b = new bytes32[](10);

        a[0] = 1;
        a[1] = 2;

        uint8[3] memory c = [1, 2, 3]; // 함수안에서 리터럴을 통해 배열 초기화할 때의 저장위치는 memory
        uint8[3] d = [1, 2, 3]; // 리터럴을 통해서 초기화 하는데, 저장위치 memory를 설정해 주지 않아서 에러가 뜬다. 

        myArray.push(5); // 상태변수 myArray 배열에 push 맴버를 써서 배열 끝에 숫자 5를 저장
        uint myArrayLength = myArray.length;  // length 맴버를 써서 myArray배열의 길이를 확인 --> myArrayLength 값 = 1
    }
}

contract MyContract3 {
    struct Student{
        string studentName;
        string gender;
        uint age;
    }

    Student[] students;

    function addStudent(string _name, string _gender, uint _age) public {
        students.push(Student(_name, _gender, _age)); // 상태변수 배열에 새로운 Student 추가

        Student storage updateStudent = students[0]; // storage에 저장하는 새로운 Student 선언
                                                     // 상태변수 students 배열의 첫번째 인덱스 값을 대입
                                                     // storage로 선언되었기 때문에 상태변수를 가르키는 포인터 역활을 한다. 
        
        updateStudent.age = 55; // updateStudent는 상태변수의 포인터이기 때문에, 상태변수 student 배열의 첫번째 인덱스의 age 필드를 55로 변경한다!! 

        Student memory updateStudent2 = students[0]; // memory에 저장하는 새로운 Student 선언
                                                     // 상태변수 students 배열의 첫번째 인덱스 값을 복사 및 대입

        updateStudent2.age = 20; // storage 형식과는 다르게 상태변수가 변경되는것이 아닌, updateStudent2의 age 필드 값을 20으로 변경한다. 

        students[0] = updateStudent2; //  memory 배열의 값을 상태변수에 직접 대입해줘야 students 값이 영구적으로 변경된다.                   
    }

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
        Student storage student = studentInfo[_studentId];   // _studentId 키값으로 이루어진 특정 Student 구조체 정보를 생성한다. 

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