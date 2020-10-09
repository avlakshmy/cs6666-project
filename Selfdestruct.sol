pragma solidity ^0.4.17;

contract Foo {
    address account;

    function bal() public view returns (uint) { return this.balance; }

    function initAccountAddress(address acc) public {
        account = acc;
    }

    function somethingDangerous () public payable {
        require(this.balance > 0);
        selfdestruct(address(0));
    }
}

contract Exploit {
    function () public payable {}

    function bal() public view returns (uint) { return this.balance; }

    function pay (address payee) public {
        selfdestruct(payee);
    }
}
