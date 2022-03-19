import { ethers } from "hardhat";

async function airdropToken() {

    const claimerAddress = "0x3279f2Ef6a0Dd7A6c3ecAbf1c876e43eCAcBFf37";
  
    const airdrop = await ethers.getContractFactory("TRDROP");
    const deployAirdrop = await airdrop.deploy();
    await deployAirdrop.deployed();

    console.log(await deployAirdrop.claimAirDrop(["0xc8146cb19de45f8fd814800fd5d92caf0c1488605ecbc9c39d1cd07b99e73b81"], 2, 200000, claimerAddress))
    
    console.log("Sleeping.....");
    console.log(await deployAirdrop.getStatus(claimerAddress));
    console.log("Deployed to:", deployAirdrop.address);

    
  // Wait for etherscan to notice that the contract has been deployed
  await sleep(100000);

  // Verify the contract after deploying
  //@ts-ignore
  await hre.run("verify:verify", {
    address: deployAirdrop.address,
    constructorArguments: [],
  });
}

function sleep(ms: number) {
    return new Promise((resolve) => setTimeout(resolve, ms));
}

airdropToken().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  