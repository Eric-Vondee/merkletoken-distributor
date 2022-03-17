import { ethers } from "hardhat";

async function token() {

    const address = "0x845dA5011f60dF971025E48b831D61f0f7662674";

    const airdrop = await ethers.getContractFactory("TDROP");
    const deployToken = await airdrop.deploy();

    await deployToken.deployed();

    console.log("Token deployed to:", deployToken.address);
}

token().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  