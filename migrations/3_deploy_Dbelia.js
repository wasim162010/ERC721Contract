const DbeliaMintNFT = artifacts.require("DbeliaMintNFT");

module.exports = function (deployer) {
  deployer.deploy(DbeliaMintNFT,"DbeliaMintNFT","DBNFT");
};
