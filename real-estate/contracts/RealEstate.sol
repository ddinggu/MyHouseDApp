pragma solidity ^0.4.23;

contract RealEstate {
    struct Buyer { // 구매자의 상세정보를 mapping 해서 관리하기 위해 struct 설정 
        address buyerAddress;
        bytes32 name;
        uint age;
    }

    mapping (uint => Buyer) public buyerInfo; // buyerInfo 로 mapping을 통해 구매자 상세정보를 관리

    // 배포할때 사용된 계정이 컨트랙의 소유자가 되도록 만든다. 
    address public owner;
    // 구매자의 id를 저장하기 위한 배열을 설정 
    address[10] public buyers;

    // 이벤트가 생성되면, 이벤트의 내용도 블록안에 저장이 된다!!
    event LogBuyRealEstate(
        address _buyer,
        uint _id
    );
        
    // 컨트랙을 배포할 때는 어떤 계정을 선택하여 선택한 계정을 통해서 배포해야 한다. 
    // 배포 단계에서 생성자가 호출이 되는데, 이 컨트랙의 주인은 배포하는데 쓰이는 현재 계정이다라고 선언해주는 목적이다.
    // owner라는 부동산 소유자를 지정하여 owner가 가나슈의 첫번째 주소를 가리킨다. 또한, 모든 돈을 먹는다. 
    constructor() public {
        // 현재 사용하는 계정으로 생성자나 함수를 불러오는것이 msg.sender
        // 값은 주소형을 갖고 있다. 
        owner = msg.sender; 
    }

    function buyRealEstate(uint _id, bytes32 _name, uint _age) public payable {
        // require : 인자로 전달되는 값이 false라면, 모든 작업을 중단하고 상태를 초기로 되돌리게 강제하는 도구.
        require(_id >=0 && _id <= 9); // id가 10개가 있으므로 10 아래의 id값만 받도록 한다. 
        buyers[_id] = msg.sender; // 함수를 사용하고 있는 계정(트랜잭션을 활성화 하는 주체)를 배열에 담아둔다. 
        buyerInfo[_id] = Buyer(msg.sender, _name, _age); // msg는 트랜잭션의 활성 당시에 영향을 받으므로 항상 바뀔 수 있다. 

        owner.transfer(msg.value); // 이더를 계정으로 이동할때 transfer 사용 , msg.value는 transfer로 넘어온 이더를 뜻하고 항상 wei만 받을 수있다. 

        // owner에게 에더가 전송되고 이벤트가 발생해야한다. 
        emit LogBuyRealEstate(msg.sender, _id);
    }
    
    function getBuyerInfo(uint _id) public view returns(address, bytes32, uint){
        Buyer memory buyer = buyerInfo[_id];
        
        return (buyer.buyerAddress, buyer.name, buyer.age);
    }

    function getAllBuyers() public view returns(address[10]){
        return buyers;
    }
}
