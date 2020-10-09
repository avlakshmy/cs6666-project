pragma solidity ^0.4.17;

contract Missing {
    address public owner;

    modifier onlyowner { require(msg.sender==owner); _; }

    function () public payable {}

    function missing() public { owner = msg.sender; }

    function withdraw() public onlyowner { owner.transfer(this.balance); }

    function bal() public view returns (uint) { return this.balance; }
}
