async function main() {
    var baseUri = 'ipfs://QmXaQXWnnt7i7ja9fVi5jWqMSTMN4Uxf3tMw9s8hqA3jqf/';
    const MyNFT = await hre.ethers.getContractFactory("MyNFT");
    console.log('Deploying MyNFT');
    const contract = await MyNFT.deploy(baseUri);
    await contract.deployed();
    console.log("MyNFT deployed to:", contract.address);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});