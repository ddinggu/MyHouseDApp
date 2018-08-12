매물구입함수 (buyRealEstate) 생성 후 과정

truffle migrate --compile-all --reset --network ganache 
    : 기존에 migrate 된 contract들을 변경된 contract들로 컴파일과정을 거친다. 

truffle console --network ganache 
    : truffle shell 실행 

truffle(ganache)> RealEstate.deployed().then(function(instance){ app =instance});
    : RealEstate 컨트랙을 전역변수 app으로 선언

truffle(ganache)> app.buyRealEstate(0, 'ddinggu' , 19 , {from: web3.eth.accounts[1], value : web3.toWei(1.50, "ether")});
    : buyRealEstate 함수를 실행하기 위해 구매자 노드 및 구매 금액 설정 ( 함수의 마지막 인자값에 object 형식으로 넣어준다. )
      ** back에서는 wei단위로 이동이 되어야 되기 때문에 toWei(.., 'ether')라고 ether 값을 선언해줘야 한다!

-------------------

truffle(ganache)> app.LogBuyRealEstate({},{fromBlock : 0, toBlock :'latest'}).watch(function(error, event) { console.log(event);})
    인자값들 : filter / Block scope
    .watch : 변화를 감지하고 있겠다는 뜻. 

truffle(ganache)> app.buyRealEstate(0, 'ddinggu', 19, {from : web3.eth.accounts[1], value : web3.toWei(1.50, 'ether')})

console.log(event) : 

{ logIndex: 0,
  transactionIndex: 0,
  transactionHash: '0xdb7acc9a5ae809f28ceddc69b8e25aa789c6d652bff9e0c302f437ae44d1669f',
  blockHash: '0xa6dba8c62d2895050f19f651f34177fd4b8726b85fd4f4eba5c60d390cbe094c',
  blockNumber: 22,
  address: '0xcdb92807be2b9af6947f4f7b49488c4d55fb6e39',
  type: 'mined',
  event: 'LogBuyRealEstate',
  args:
   { _buyer: '0x2dcca9b61e50d79a90a813fcd6a42c3a3ac52e6f',
     _id: BigNumber { s: 1, e: 0, c: [Array] } } }


block에 저장되는 부분 
logs:
   [ { logIndex: 0,
       transactionIndex: 0,
       transactionHash: '0xdb7acc9a5ae809f28ceddc69b8e25aa789c6d652bff9e0c302f437ae44d1669f',
       blockHash: '0xa6dba8c62d2895050f19f651f34177fd4b8726b85fd4f4eba5c60d390cbe094c',
       blockNumber: 22,
       address: '0xcdb92807be2b9af6947f4f7b49488c4d55fb6e39',
       type: 'mined',
       event: 'LogBuyRealEstate',
       args: [Object] } ] } // 추후에 front에서 args부분을 통해 우리가 지정한 event를 찾아 볼 수 있다. 



--------------------------

app.getBuyerInfo(0);

[ '0x2dcca9b61e50d79a90a813fcd6a42c3a3ac52e6f',
  '0x6464696e67677500000000000000000000000000000000000000000000000000', // name은 bytes32로 이루어져 있어서 front에서 변환작업이 추가로 필요하다. 
  BigNumber { s: 1, e: 1, c: [ 19 ] } ]

  truffle(ganache)> app.getAllBuyers();

[ '0x2dcca9b61e50d79a90a813fcd6a42c3a3ac52e6f',
  '0x0000000000000000000000000000000000000000',
  '0x0000000000000000000000000000000000000000',
  '0x0000000000000000000000000000000000000000',
  '0x0000000000000000000000000000000000000000',
  '0x0000000000000000000000000000000000000000',
  '0x0000000000000000000000000000000000000000',
  '0x0000000000000000000000000000000000000000',
  '0x0000000000000000000000000000000000000000',
  '0x0000000000000000000000000000000000000000' ]

------------

mocha, chai 를 통한 테스팅 : 

$  truffle test --network ganache

---------------

RealEstate.deployed().then(function(instance){ app = instance; })에서 
instance는 ./Bulid/contracts/RealEstates.json( migrate 할때 생성되는 json 정보) 파일의 내용을 return 한다. 
특히, RealEstate.json 파일을 아티팩트라고 하는데, 이 안에는 ABI가 포함되어 있고 이 ABI는 블록체인에 배포된 부동산 컨트랙과 
상호작용하기 위한 컨트랙 함수들과 변수들이 포함되어 있다. 

이를 불러와서 전역변수 app에 abi들을 선언하게 되어 컨트랙 함수 및 변수들을 사용할 수 있게 되었다. 



