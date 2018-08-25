App = {
  web3Provider: null,
  contracts: {},
	
  init: function() {
    $.getJSON('../real-estate.json', data => {
      let list = $('#list');
      let template = $('#template');

      for(let i=0; i<data.length; i++){
        template.find('img').attr('src', data[i].picture);
        template.find('.id').text(data[i].id);
        template.find('.type').text(data[i].type);
        template.find('.area').text(data[i].area);
        template.find('.price').text(data[i].price);

        list.append(template.html());
      }
    })

    return App.initWeb3(); // template 생성후 initWeb3가 실행되도록 한다. 
  },

  initWeb3: function() {
    if(typeof web3 !== 'undefined'){ // browser에 metamask가 설치되어있는경우 
      // metamask의 web3인스턴스를 가져온다. 
      App.web3Provider = web3.currentProvider; // 공급자의 정보를 변수로 저장
      web3 = new Web3(web3.currentProvider); // 공급자의 정보를 기준으로 web3 object를 생성. 
    }
    else{
      // browser에 web3가 없는경우 로컬공급자의 rpc서버로 이동하여 공급자의 정보를 가져온다. 
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:8545');
      web3 = new Web3(App.web3Provider)
    }

    return App.initContract();
  },

  initContract: function() {
    // 우리가 만들어 놓은 스마트 컨트랙을 인스턴화 하는 함수 
    
    $.getJSON('RealEstate.json', (data) => { // abi와 주소를 가져오게 된다. 
      App.contracts.RealEstate = TruffleContract(data); // 트러플 라이브러리가 제공하는 메소드를 통해 인스턴스화 시킨다. 
      App.contracts.RealEstate.setProvider(App.web3Provider); // web3Provider를 통해 컨트랙의 공급자를 설정 
      return App.listenToEvents();
    })
  },

  buyRealEstate: function() {	
    // modal의 모든 input field의 값들을 가져온다. 
    let id = $('#id').val();
    let price = $('#price').val();
    let age = $('#age').val();
    let name = $('#name').val();

    web3.eth.getAccounts((error, accounts) =>{
      error ? console.error(error) : null
      
      let account = accounts[0];

       // contract 인스턴스화 된 것을 
      App.contracts.RealEstate.deployed().then((instance) => {
        let nameUtf8Encoded = utf8.encode(name); // 이름을 utf8로 인코딩
        // 인코딩된 아이디를 다시 hex로 인코딩해줘야한다. 
        // 
        return instance.buyRealEstate(id, web3.toHex(nameUtf8Encoded), age, {from: account, value : price}); 
      }).then(()=>{
        $('#name').val('');
        $('#age').val('');
        $('#buyModal').modal('hide');
      }).catch((err)=> console.error(err.message));
    })
  },

  loadRealEstates: function() {
    App.contracts.RealEstate.deployed().then((instance) => {
      return instance.getAllBuyers.call();
    }).then((buyers) => {
      for(let i=0; i<buyers.length; i++){
        // 주소의 초기화는 null이 아닌, 0x000.. 값을 갖게 된다. 
        if(buyers[i] !== '0x0000000000000000000000000000000000000000'){
            let imgType = $('.panel-realEstate').eq(i).find('img').attr('src').substr(7);

            switch(imgType){
              case 'apartment.jpg' : 
                $('.panel-realEstate').eq(i).find('img').attr('src', 'images/apartment_sold.jpg')
                break;
              case 'townhouse.jpg' : 
                $('.panel-realEstate').eq(i).find('img').attr('src', 'images/townhouse_sold.jpg')
                break;
              case 'house.jpg' : 
                $('.panel-realEstate').eq(i).find('img').attr('src', 'images/house_sold.jpg')
                break;
            }

            $('.panel-realEstate').eq(i).find('.btn-buy').text('매각').attr('disabled', true);
            $('.panel-realEstate').eq(i).find('.btn-buyerInfo').removeAttr('style');
         } 
      }
    }).catch((err) => console.error(err.message));
  },
	
  listenToEvents: function() {
    App.contracts.RealEstate.deployed().then((instance) => {
      instance.LogBuyRealEstate({}, {fromBlock : 0, toBlock : 'latest'}).watch((err, event)=>{
        !err ? $('#events').append(`<p> ${event.args._buyer} 계정에서 ${event.args._id} 번 매물을 매입했습니다. </p>`) : console.error(err);
      })
    })
   return App.loadRealEstates();
  }

};

// html이 모두 로드되었을때 실행되는 함수들
$(function() {
  $(window).load(function() {
    App.init();
  });

  // 해당 템플렛에 modal이 떠 있다면, 콜백의 함수들을 실행해라.
  $('#buyModal').on('show.bs.modal', (e) => {
    // template의 class 로 이미 지정된 id, price 값들을 불러온다. 
    let id = $(e.relatedTarget).parent().find('.id').text();
    // 가격을 wei로 변환(실제로 거래에 올릴때는 wei로 올려야 하기 때문에!! )
    let price = web3.toWei(parseFloat($(e.relatedTarget).parent().find('.price').text() || 0 ), "ether");
    
    // hidden 속성에 id, price 값들을 찾아놓은 것들을 전달해준다. 
    $(e.currentTarget).find('#id').val(id);
    $(e.currentTarget).find('#price').val(price);
  })

  $('#buyerInfoModal').on('show.bs.modal', (e) => {
    let id = $(e.relatedTarget).parent().find('.id').text();

    // 구매자 정보를 가져와서 front에 제공하기 위함.
    App.contracts.RealEstate.deployed().then((instance) => {
      return instance.getBuyerInfo.call(id);
    }).then((buyerInfo)=>{
      $(e.currentTarget).find('#buyerAddress').text(buyerInfo[0]);
      $(e.currentTarget).find('#buyerName').text(web3.toUtf8(buyerInfo[1])); // utf-8 깨짐방지
      $(e.currentTarget).find('#buyerAge').text(buyerInfo[2]);

    })
  })

});
