const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    //const deployer = "0x61A9d45a1B9bC1A14103F07B80b729A23d8C3a21";
  
    console.log("Deploying contracts with the account:", deployer.address);
    console.log("Account balance:", (await deployer.getBalance()).toString());
  
    const DbankFactory = await ethers.getContractFactory("DbankFactory");
    const dbankFactory = await DbankFactory.deploy();
    const Storage = await ethers.getContractFactory("Store");
    const storage = await Storage.deploy();
    const Dbank = await ethers.getContractFactory("Dbank");
    const dbank = await Dbank.deploy(2, '0x61A9d45a1B9bC1A14103F07B80b729A23d8C3a21')
  
    console.log("Bank Factory Contract Address is:", dbankFactory.address);
    console.log("Storage Contract Address is:", storage.address);
    console.log("Bank Contract Address is:", dbank.address);
  
    // For each contract, pass the deployed contract and name to this function to save a copy of the contract ABI and address to the front end.
    saveFrontendFiles(dbankFactory, "DbankFactory");
    saveFrontendFiles(storage, "Store");
    saveFrontendFiles(dbank, "Dbank")
  }
  
  function saveFrontendFiles(contract, name) {
    const fs = require("fs");
    const contractsDir = __dirname + "/../../contractsData";
  
    if (!fs.existsSync(contractsDir)) {
      fs.mkdirSync(contractsDir);
    }
  
    fs.writeFileSync(
      contractsDir + `/${name}-address.json`,
      JSON.stringify({ address: contract.address }, undefined, 2)
    );
  
    const contractArtifact = artifacts.readArtifactSync(name);
  
    fs.writeFileSync(
      contractsDir + `/${name}.json`,
      JSON.stringify(contractArtifact, null, 2)
    );
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });
