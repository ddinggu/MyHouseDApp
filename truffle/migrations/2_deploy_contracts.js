var MyContract = artifacts.require("./MyContract.sol"); // contract 폴더의 파일을 가져온다.

module.exports = function(deployer) {
  deployer.deploy(MyContract); // evm에 배포하게 된다. 
};
 