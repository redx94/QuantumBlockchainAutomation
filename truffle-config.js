module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",    // Localhost
      port: 8545,           // Ganache CLI default port
      network_id: "*",      // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "0.8.0",     // Use the correct Solidity version
    },
  },
};
