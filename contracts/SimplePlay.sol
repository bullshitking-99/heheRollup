// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Coin {
    // 关键字“public”让这些变量可以从外部读取
    // You can declare an array as public, and Solidity will automatically create a getter method for it.
    // Other contracts would then be able to read from, but not write to, this array.
    address public minter;
    mapping(address => uint) public balances;

    // 轻客户端可以通过事件针对变化作出高效的反应
    // Events are a way for your contract to communicate that something happened on the blockchain to your app front-end
    event Sent(address from, address to, uint amount);

    // 这是构造函数，只有当合约创建时运行
    constructor() {
        minter = msg.sender;
    }

    // In Solidity, functions are public by default.
    // This means anyone (or any other contract) can call your contract's function and execute its code.
    // on the other hands, declare private means only other functions within our contract will be able to call this function
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // Errors allow you to provide information about
    // why an operation failed. They are returned
    // to the caller of the function.
    error InsufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
