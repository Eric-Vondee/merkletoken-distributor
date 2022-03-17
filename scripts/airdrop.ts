import { ethers } from "hardhat";

async function airdropToken() {

    const address = "0x845dA5011f60dF971025E48b831D61f0f7662674";

    const airdrop = await ethers.getContractFactory("AIRDROP");
    const deployAirdrop = await airdrop.deploy("0x5c40fa1ddf67b14371ab96b022aa271fc8d4ca7f33f5d9a3b14f2a1035130edb");

    await deployAirdrop.deployed();

    console.log(await deployAirdrop.ad))

    console.log("Token deployed to:", deployAirdrop.address);
}

airdropToken().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  