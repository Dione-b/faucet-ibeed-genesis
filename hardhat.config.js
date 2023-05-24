const dotenv = require("dotenv");
require("@nomicfoundation/hardhat-toolbox");

dotenv.config({
  path: ".env",
});

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
      mumbai: {
        url: process.env.STAGING_ALCHEMY_KEY || '',
        accounts: [process.env.PRIVATE_KEY] || '',
      },
      goerli: {
        chainId: 5,
        url: process.env.GOERLI_ALCHEMY_KEY || '',
        accounts: [process.env.PRIVATE_KEY] || '',
      },
    },
    etherscan: {
      apiKey: {
        goerli: process.env.ETHERSCAN_API_KEY || ''
      }
    }
};
