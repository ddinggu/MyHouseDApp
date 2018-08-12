var RealEstate = artifacts.require('./RealEstate.sol');

contract('RealEstate', function(accounts){ // accounts는 열려있는 계좌들을 가르킴
    var realEstateInstance;

    it('컨트랙의 소유자 초기화 테스팅', function(){
        return RealEstate.deployed().then(function(instance){
            realEstateInstance = instance;
            return realEstateInstance.owner.call();
        }).then(function(owner){ // truffle은 소문자, ganache는 대문자이기 때문에 통일시킨다.
            assert.equal(owner.toUpperCase(),accounts[0].toUpperCase(),'owner가 가나슈 첫번째 계정과 동일하지 않습니다.')
        })
    });

    it('가나슈 두번째 계정으로 매물아이디 0번 매입 후 이벤트 생성 및 매입자 정보와 buyers 배열 테스팅', function(){
        return RealEstate.deployed().then(function(instance){
            realEstateInstance = instance;
            return realEstateInstance.buyRealEstate(0, 'ddinggu', 19, {from : accounts[1], value : web3.toWei(1.50, 'ether')});
        }).then(function(receipt){
            assert.equal(receipt.logs.length, 1, '이벤트 하나가 생성되지 않았습니다.');
            assert.equal(receipt.logs[0].event, 'LogBuyRealEstate', '이벤트가 LogBuyRealEstate가 아닙니다.');
            assert.equal(receipt.logs[0].args._buyer, accounts[1], '매입자가 가나슈 두번째 계정이 아닙니다.');
            assert.equal(receipt.logs[0].args._id, 0, "매물 아이디가 0이 아닙니다.");
            return realEstateInstance.getBuyerInfo(0);
        }).then(function(buyerInfo){
            assert.equal(buyerInfo[0].toUpperCase(), accounts[1].toUpperCase(), '매입자의 계정이 가나슈 두번째 계정과 일치하지 않습니다.');
            // bytes32 헥스로 저장되기 때문에 string 값으로 변환하는 작업 + 0000 값들을 제거하는 정규표현식 사용 
            assert.equal(web3.toAscii(buyerInfo[1]).replace(/\0/g, ''), "ddinggu", '매입자의 이름이 ddinggu가 아닙니다.'); 
            assert.equal(buyerInfo[2], 19, '매입자의 나이가 19살이 아닙니다.');
            return realEstateInstance.getAllBuyers();
        }).then(function(buyers){
            assert.equal(buyers[0].toUpperCase(), accounts[1].toUpperCase(), 'Buyer 배열 첫번째 인덱스의 계정이 가나슈의 두번째 계정과 같지 않습니다.')
        })
    })
})