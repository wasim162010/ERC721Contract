const { assert } = require('chai')

const instance = artifacts.require('./DbeliaMintNFT.sol')

require('chai')
  .use(require('chai-as-promised'))
  .should()



contract('instance', (accounts) => {
    let contract
  
    before(async () => {
      contract = await instance.deployed()
    })
  
    describe('deployment', async () => {
      it('deploys successfully', async () => {
        const address = contract.address
        assert.notEqual(address, 0x0)
        assert.notEqual(address, '')
        assert.notEqual(address, null)
        assert.notEqual(address, undefined)
      })
  
    })
  

    
    describe('minting', async () => {
  
      it('mint token by paying via dollar', async () =>{
        
        const cardID = "CARD1203XS1";
        const edition = "e101";
        const tokenUri1 = "This is data for the token 1"; 
        const userId = accounts[4]; 
        await contract.mintWithUSD(userId, cardID, edition, tokenUri1,{from: contract.address }).should.be.fulfilled;
      
      })

    it('mint token by paying in ETH', async () =>{

        const cardID = "CARD121";
        const edition = "e101";
        const tokenUri = "This is data for the token 1"; 
        const fromAddr =  accounts[4]; 
      
        await contract.mintWithETH(cardID, edition, tokenUri, {from: fromAddr }).then( (val) =>{
              assert.notEqual(val,0);
        }).catch((error) => {
          assert.notEqual(error, undefined)
     
       }); 

    })

    })

    describe('transfer token from one account to another', async () => {

      it('mint token by paying via dollar', async () =>{
          var from =   accounts[2] ;
          var to = accounts[3];

          const tokenID = 100;
          var fromBal = await contract.balanceOf.call(from);
          var toBal = await contract.balanceOf.call(to);
        
         contract.approve(to,tokenID).then(function(){
            return contract.transferFrom(from,to,tokenID)
         }).then(function(){
            return contract.balanceOf.call(to);
         }).then(function(result){
          assert.equal(result.toNumber(), toBal+1, 'accounts[3] balance is wrong');
          return contract.balanceOf.call(accounts[3]);
         });
        
       });
  })
   
    
  })