import "forge-std/Test.sol";
import "../src/GatekeeperTwoAttack.sol";


contract GatekeeperTwoTest is Test {
    GatekeeperTwo gatekeeper;
    GatekeeperTwoAttack gatekeeperAttack;
    address alice = makeAddr("alice"); // детерминированный тест-адрес

    function setUp() public { 
        vm.deal(alice, 10 ether);       // выдать alice ETH
        gatekeeper = new GatekeeperTwo();
        gatekeeperAttack = new GatekeeperTwoAttack(address(gatekeeper));
        //Attack is called from constructor so there is no need for any further tests
    }


}