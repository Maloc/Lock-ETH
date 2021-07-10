const LockEth = artifacts.require("Lock");

module.exports = function (deployer) {
    deployer.deploy(LockEth);
};