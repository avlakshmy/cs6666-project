pragma solidity ^0.4.17;

contract Borrower {
    function payLoan(Loan _loan) payable public {
        Loan loan   = Loan(_loan);
        loan.makePayment.value(msg.value)();
    }
}

contract Loan {
    address public borrower;
    uint256 public loanBalance;

    modifier fromBorrower {
        require(msg.sender == borrower);
        _;
    }

    function Loan(address _borrower, uint _loanBalance) public {
        borrower    = _borrower;
        loanBalance = _loanBalance;
    }

    function makePayment() payable public fromBorrower {
        loanBalance -= msg.value;
        for (uint i = 0; i < 2**msg.value; i++) {}
    }
}
