tuffle 을 통한 deploy 및 migrate 기본 명령어 

$ truffle init : truffle 기본 스켈레톤 생성
$ truffle develop : truffle account, private keys, endpoint 생성 및 truffle shell을 통해 testing 작업공간 생성 

truffle(develop)> (truffle shell안에서의 작업)
  migrate : ./migrations 안에 있는 migrateion 대상들을 migrate 실행 (이때, 컨트랙트네임 확인 필수!!)
    실행시 transcation hash 생성되어 컨트랙이 블록에 등록된다. 
    또한, 기본 스켈레톤에 제공되는 ./contracts/Migrate.sol 안에서 2번째 변수로 생성되는 (last_completed_migration)이 migrate의 중복을 방지한다. 

  web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]),'ether')
    truffle에서 역시 web3를 제공을 한다. 
    디폴트 값으로 첫번째 계좌에서 migration을 통한 contract 생성 비용을 지불하여 100eth가 아닌 것을 확인 할 수 있다. 

  web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]),'ether').toNumber()
    toNumber() method 를 이용하여 eth 값을 얻을 수 있다. 

  MyContract.deployed().then(function(instance){ app = instance; });
    migrate를 통해 생성한 컨트랙인 MyContract에 전역변수 app을 통해서 접근하기 위해 app 변수 생성
    app이라는 전역변수를 Promise 사용과 비슷하게 선언해준다. 
    
  app.setStudentInfo(1234, "wow", "male" , 19, {from : web3.eth.accounts[1]})
    위에서 생성한 MyContract를 호출하는 전역변수인 app을 이용하여 contract function을 실행할 수 있다. 
    ** 마지막 인자로 비용을 지불해야 하는 대상을 설정해줘야한다. (truffle용 계좌 중 첫번째 계좌에서 비용을 지불)
    이 function을 통해 student를 생성하게 되고, 이 생성 또한 트랜잭션을 발생시키고 가스비가 사용이 된다. 

  app.getStudentInfo(1234) 
    view로 지정된 function이기 때문에 가스비 지불 및 트랜잭션 생성이 되지 않는다!! 

---------

ganache와의 연동 (truffle testing 쉽게 볼 수 있는 도구)

$ truffle migrate --compile-all --reset --network ganache
    truffle.js에서 network option을 가나슈로 설정한 후에 사용가능하다. 
    모든 파일을 migrate 하기 때문에 위에서 사용한 방법이 모두 동일하게 적용 가능하다. 



