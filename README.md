# 부동산 스마트컨트랙트 개발 

**설치 과정**

geth를 사용하기 위한 Go 설치방법 및 적용방법 : 
[https://golang.org/doc/install]  안내 따라가기 

geth 설치방법 및 적용 방법 : 
[https://anpigon.github.io/ethereum-geth-install-for-mac-md/] \
[https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Mac]\
[https://ethereum.github.io/go-ethereum/downloads/]

제네시스 블록 추출 및 적용 : $ puppeth 를 이용
 
truffle : [https://truffleframework.com/docs/truffle/overview]

----------------------------

# 학습 목표 

### 학습도구 설치

학습에 필요한 도구인 geth, Golang, MetaMask, Truffle, Ganache, Node.js 설치 및 확인

### 기본개념 

컨트랙의 구조 
접근제어자
함수 타입 제어자
값 타입
데이터 위치
배열 
구조체
맵핑
구입함수
Remix 테스팅, 디버깅
가스

### 프론트엔드 개발

매물 템플릿 작성 및 렌더링 
Web3 & 컨트랙 인스턴스화
Modal 
매입자 정보 및 데이터 전달
컨트랙 매물구입함수 연결 
UI, Event 연결 


--------------------------
# 과정

8/5  
1. GO, geth, metamask, ganache 설치 후 제네시스 블록 및 계정 생성
2. geth를 통한 노드 첫 실행, DAG 파일 생성, 채굴과정 확인 
3. geth JavaScript Shell 을 통한 트랜잭션 및 api 사용 
4. 데이터 타입 및 스마트 계약 이론 숙지 
5. 가스, 옵코드, 컨트랙 최적화 

--------------
8/12 
1. truffle 을 통한 컨트랙 migration , deploy testing 및 ganache와 연결
2. 컨트랙트 기초 설계 
3. event, truffle console, ABI, migrate, ganache deploy 숙지
4. mocha, chai unit testing

------------- 
8/25 
1. lite-server 를 통한 localhost에서의 실행
2. data는 json 파일에서 import를 통해 제공받음
3. bootstrap & jQuery를 이용한 front 구성 및 truffle middleware를 이용한 back과의 연결 
4. RPC error 해결법
5. 기존에 구축한 contract를 client metamask를 통해 계약거래 확인 및 client측의 event 연결



