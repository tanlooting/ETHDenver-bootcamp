require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
// require("@nomiclabs/hardhat-etherscan")
// require("hardhat-gas-reporter")
// require("solidity-coverage")

const MAINNET_RPC_URL = process.env.MAINNET_RPC_URL;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    hardhat: { 
      chainId: 31337,
      forking: {
        url: MAINNET_RPC_URL,
      }
    }
  }
};
