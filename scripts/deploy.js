const hre = require("hardhat");

async function main() {
  console.log("Starting deployment of Supply Chain Tracking System...");

  // Get the deployer account
  const [deployer] = await hre.ethers.getSigners();
  
  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.provider.getBalance(deployer.address)).toString());

  // Deploy the SupplyChainTracking contract
  const SupplyChainTracking = await hre.ethers.getContractFactory("SupplyChainTracking");
  
  console.log("Deploying SupplyChainTracking contract...");
  const supplyChainTracking = await SupplyChainTracking.deploy();

  await supplyChainTracking.waitForDeployment();
  
  const contractAddress = await supplyChainTracking.getAddress();
  
  console.log("✅ SupplyChainTracking contract deployed successfully!");
  console.log("📍 Contract Address:", contractAddress);
  console.log("🔗 Network:", hre.network.name);
  console.log("⛽ Gas Used: Check transaction for details");

  // Verify deployment by calling a view function
  try {
    const productCounter = await supplyChainTracking.productCounter();
    console.log("✅ Contract verification successful - Product Counter:", productCounter.toString());
  } catch (error) {
    console.log("❌ Contract verification failed:", error.message);
  }

  // Log deployment information for reference
  console.log("\n📋 Deployment Summary:");
  console.log("=".repeat(50));
  console.log(`Contract Name: SupplyChainTracking`);
  console.log(`Network: ${hre.network.name}`);
  console.log(`Contract Address: ${contractAddress}`);
  console.log(`Deployer Address: ${deployer.address}`);
  console.log(`Deployment Time: ${new Date().toISOString()}`);
  console.log("=".repeat(50));

  // Save deployment info to a file for future reference
  const fs = require('fs');
  const deploymentInfo = {
    contractName: "SupplyChainTracking",
    contractAddress: contractAddress,
    network: hre.network.name,
    deployer: deployer.address,
    deploymentTime: new Date().toISOString(),
    chainId: hre.network.config.chainId
  };

  if (!fs.existsSync('./deployments')) {
    fs.mkdirSync('./deployments');
  }

  fs.writeFileSync(
    `./deployments/${hre.network.name}-deployment.json`,
    JSON.stringify(deploymentInfo, null, 2)
  );

  console.log(`\n💾 Deployment info saved to ./deployments/${hre.network.name}-deployment.json`);
  
  return contractAddress;
}

// Execute deployment
main()
  .then((contractAddress) => {
    console.log(`\n🎉 Deployment completed successfully!`);
    console.log(`🚀 You can now interact with your contract at: ${contractAddress}`);
    process.exit(0);
  })
  .catch((error) => {
    console.error("❌ Deployment failed:", error);
    process.exit(1);
  });
