// see hardhat-deploy documentation
// https://hardhat.org/hardhat-runner/docs/guides/deploying

const hre = require("hardhat");

async function main() {

  const Token = await hre.ethers.getContractFactory("Token");
  const Exchange = await hre.ethers.getContractFactory("Exchange")
  

  const _token = await Token.deploy('1000000000000000000000000')
  const token = await _token.deployed()

  const _exchange = await Exchange.deploy(token.address)
  const exchange = await _exchange.deployed()
  
  await token.transfer(exchange.address, '1000000000000000000000000')

  console.log(
    `Token deployed to ${token.address} and Exchange deployed to ${exchange.address}.`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
