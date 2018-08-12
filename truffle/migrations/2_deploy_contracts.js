// 파일명의 맨 앞의 숫자는 컨트랙으로 올라가는 순서이다. 따라서, 이 컨트랙은 2번째로 올라가게 된다. 

var MyContract = artifacts.require("./MyContract.sol"); // contract 폴더의 파일을 가져온다.

module.exports = function(deployer) {
  deployer.deploy(MyContract); // evm에 배포하게 된다. 
};
 