import "forge-std/Test.sol";
import "../src/GatekeeperOneAttack.sol";


contract GatekeeperOneTest is Test {
    GatekeeperOne gatekeeper;
    GatekeeperOneAttack gatekeeperAttack;
    address alice = makeAddr("alice"); // детерминированный тест-адрес

    function setUp() public {           // выполняется ПЕРЕД КАЖДЫМ test_
        gatekeeper = new GatekeeperOne();
        gatekeeperAttack = new GatekeeperOneAttack(address(gatekeeper));
        vm.deal(alice, 10 ether);       // выдать alice ETH
    }

    // function test_deposit() public {    // функции с префиксом test_ = тесты
    //     vm.prank(alice);                // msg.sender СЛЕДУЮЩЕГО вызова = alice
    //     gatekeeper.enter(bytes8(0x1000000000001f38));
    //     // проверка
    // }

    function test_attack() public {
        vm.prank(alice);
        gatekeeperAttack.attack();

    }
}