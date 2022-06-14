const { expect } = require('chai');

describe("Token contract", function () {
    let hardhatToken;
    let baseUri = 'ipfs://QmXaQXWnnt7i7ja9fVi5jWqMSTMN4Uxf3tMw9s8hqA3jqf/';
    let maxSupply = 5;

    beforeEach(async function () {
        MyNFT = await hre.ethers.getContractFactory("MyNFT");
        contract = await MyNFT.deploy(baseUri);
        await contract.deployed();
    });

    describe("Deploy", function() {
        it("Return correct name and symbol", async function() {
            expect(await contract.name()).to.equal("PenBl");
            expect(await contract.symbol()).to.equal("PNL");
        });

        it("Should set the right owner", async function () {
            const [owner] = await ethers.getSigners();
            const ownerBalance = await contract.balanceOf(owner.address);
            expect(await contract.owner()).to.equal(owner.address);
        });

        it("TokenIDs Should own by the owner", async function () {
            const [owner] = await ethers.getSigners();
            const ownerBalance = await contract.balanceOf(owner.address);

            for (var i = 1; i <= ownerBalance; i++) {
                expect(await contract.ownerOf(i)).to.equal(owner.address);
            }
        });
    });
});