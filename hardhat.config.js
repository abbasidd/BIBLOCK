require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-ignition-ethers");
require("dotenv").config();

const bscscanApiKey = process.env.BSC_APIKEY;
const PrivateKey = process.env.PRIVATE_KEY;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
    testnet: {
      url: "https://bsc-testnet-rpc.publicnode.com",
      chainId: 97,
      accounts: [PrivateKey],
    },
    mainnet: {
      url: "https://bsc-dataseed.bnbchain.org/",
      chainId: 56,
      // gasPrice: 20000000000,
      accounts: [PrivateKey],
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://bscscan.com/
    apiKey: bscscanApiKey,
  },
};
