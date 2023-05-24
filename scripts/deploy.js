const hre = require("hardhat");

async function main() {
  const FaucetIbeed = await hre.ethers.getContractFactory("IbeedFaucet");
  const Ibeed = await FaucetIbeed.deploy();

  await Ibeed.deployed();

  console.log(`Contrato deployado: `, Ibeed.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
