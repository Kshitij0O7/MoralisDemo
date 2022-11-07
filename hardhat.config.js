//require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-waffle");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  defaultNetwork: 'matic',
  networks: {
    matic: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/u6BkPZO36a94O_-G3MH3-72ontYgrkQk",
      accounts: ["f2dc2c407ff64360fd03540ac17078684a46a820096ecda826af9f86f0212590"]
    }
  },
  paths: {
    artifacts: "./backend/artifacts",
    sources: "./src/backend/contracts",
    cache: "./src/backend/cache",
    tests: "./src/backend/test"
  }
};
