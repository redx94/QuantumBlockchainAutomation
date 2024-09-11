// truffle-config.js
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,  // Ganache CLI default port
      network_id: "*",  // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "0.8.0",  // Specify the Solidity compiler version
    },
  },
};
