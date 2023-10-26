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

---

## 数据位置 data location

> how your variables and data are handled by the EVM, influence gas cost & storage layout.

- `storage`, suit for state variables that store on the blockchain, and it's automatically interpreted.
- `memory`, reserved for variables that are defined within the scope of a function.
- `Calldata`, immutable, temporary location where function arguments are stored, and behaves mostly like `memory`.
  - `calldata` 作为区块链的[历史日志（Log）部分](https://docs.soliditylang.org/en/latest/introduction-to-smart-contracts.html#logs)，不会存储为以太坊状态的一部分，但可在区块链外部进行访问，因此既能保证数据可用性，又节省了 gas, 用于在卷叠中向链上合约递交交易数据.

---

## gas 优化

### 在 struct 中打包 uint

> uint 默认为 256，太大了，且平时即使显式声明 uint8，uint16 等，也不会节省空间，但在 struct 中打包可以
> uint8 能代表的最大数是 2^8 = 256; uint16 则为 2^16 = 65536; 酱紫来算的

---

## ERC 721 token standrad

> 提供一套约定俗成的 api 和 event，以供社区协同开发

### transfer 的两种形式

- 直接转
  - `function transferFrom(address _from, address _to, uint256 _tokenId) external payable;`
- 设定代理
  - `function approve(address _approved, uint256 _tokenId) external payable;`
  - 调用 approve 会存储代理，如`mapping (uint256 => address)`，再次调用 transferFrom 时检查代理表

---

## 安全问题 overflow & underflow

> 由于 uint 是无符号整数，超出定义限制的操作会导致数值发生反常规的变化
> 如 uint8 11111111 = 255 ，将其++，会得到 00000000 = 0；
> 反之将 uint8 00000000 = 0 , --, 会得到 11111111 = 255；

一种解决方法是，使用 OpenZeppelin 的 SafeMath ，它的 library 之一。

> A library is a special type of contract in Solidity. One of the things it is useful for is to attach functions to native data types, , by using the `using` keyword

```typescript
using SafeMath for uint256;

uint256 a = 5;
// 注意下面的 a 会自动作为 add 函数的第一个参数
uint256 b = a.add(3); // 5 + 3 = 8
uint256 c = a.mul(2); // 5 * 2 = 10
```
