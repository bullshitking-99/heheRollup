# Solidity 语法笔记

---

## 函数修饰符 function modifiers

### visibility modifiers

> control when and where the function can be called from

- privite
  - 仅限本合约内
- internal
  - 本合约 + 继承合约
- external
  - 除本合约外的其它可
- public
  - 都可

### state modifiers

> how the function interacts with the BlockChain

- view
  - 只读于区块链
- pure
  - 不读也不写，与 view 一样在本地运行，external 时不消耗 gas

### custom modifiers

> define custom logic to determine how they affect a function.

- onlyOwner
  - 统一访问权限控制
- aboutLevel
  - 可验证函数参数

### payable modifier

> a special type of function that can receive Ether.
