pragma solidity ^0.4.23; // 솔리디티 컴파일러 버젼 설정

contract MyContract3 {
    struct Student {
        string studentName;
        string gender;
        uint age;
    }

    Student[] students;

    function addStudent(string _name, string _gender, uint _age) public {
        students.push(Student(_name, _gender, _age)); // 상태변수 배열에 새로운 Student 추가

        Student storage updateStudent = students[0]; // storage에 저장하는 새로운 Student 선언
        // 상태변수 students 배열의 첫번째 인덱스 값을 대입
        // storage로 선언되었기 때문에 값을 복사하는 방식이 아닌, 상태변수를 가르키는 포인터 역활을 한다.
        updateStudent.age = 55; // updateStudent는 상태변수의 포인터이기 때문에, 상태변수 student 배열의 첫번째 인덱스의 age 필드를 55로 변경한다!!

        Student memory updateStudent2 = students[0]; // memory에 저장하는 새로운 Student 선언
                                        // 상태변수 students 배열의 첫번째 인덱스 값을 복사 및 대입

        updateStudent2.age = 20; // storage 형식과는 다르게 상태변수가 변경되는것이 아닌, updateStudent2의 age 필드 값을 20으로 변경한다.

        students[0] = updateStudent2; // memory 배열의 값을 상태변수에 직접 대입해줘야 students 값이 영구적으로 변경된다.
    }
}