pragma solidity 0.8.15;

import "forge-std/test.sol";
import "../src/Viceroy.sol";

contract ViceroyTest is Test {
    Governance public governance;
    OligarchyNFT public oligarchyNFT;
    CommunityWallet public communintyWallet;

    address attacker = vm.addr(0x1);
    address _viceroy = vm.addr(0x2);
    address randomAddress = vm.addr(0x3);

    function setUp() public {
        vm.startPrank(attacker);
        OligarchyNFT oligarchyNFT = new OligarchyNFT(attacker);
        governance = new Governance(oligarchyNFT);
        communintyWallet = new CommunityWallet(address(governance));
        vm.stopPrank();
    }

    function testAppointViceroy() public {
        vm.startPrank(attacker);
        governance.appointViceroy(_viceroy, 1);
        bool isViceroyAppointed = governance.idUsed(1);
        (uint256 appointedBy, uint256 numAppointments) = governance.viceroys(_viceroy);
        assertEq(isViceroyAppointed, true);
        assertEq(appointedBy, 1);
        vm.stopPrank();
    }

    function testFail_DeposeViceroyCallerNotOwnerOfNFT() public {
        vm.startPrank(randomAddress);
        vm.expectRevert("CALLER_NOT_OWNER_OF_NFT");
        governance.deposeViceroy(_viceroy, 1);
    }
}
