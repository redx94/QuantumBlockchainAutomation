const QRNGLedger = artifacts.require("QRNGLedger");

module.exports = function (deployer) {
  deployer.deploy(QRNGLedger);
};
