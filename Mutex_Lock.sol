pragma solidity ^0.4.17;
contract StateHolder {
    uint public n;
    address public lockHolder;

    function getLock() public {
        require(lockHolder == address(0));
        lockHolder = msg.sender;
    }

    function releaseLock() public {
        require(msg.sender == lockHolder);
        lockHolder = address(0);
    }

    function set(uint newState) public returns (uint){
        require(msg.sender == lockHolder);
        if (newState > n) {
            n = newState;
        }
        return n;
    }
}

contract Honest {
    StateHolder sh;
    uint public myValue;

    function getAccess (address a) public {
        sh = StateHolder(a);
        sh.getLock();
    }

    function putMyValue(uint y) public {
        myValue = sh.set(y);
    }

    function byeBye() public {
        sh.releaseLock();
    }
}
contract Attacker {
    StateHolder sh;
    uint public finalValue;

    function capture (address a) public {
        sh = StateHolder(a);
        sh.getLock();
    }

    function malicious() public {
        for (uint i = 0; i < 100; i++) {
            finalValue = sh.set(i);
        }
        selfdestruct(address(0));
    }
}
