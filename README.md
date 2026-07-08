# openzeppelin-ethernaut

[Ethernaut](https://ethernaut.openzeppelin.com/) 워게임을 풀며 정리한 스마트 컨트랙트 취약점 분석 및 익스플로잇 기록입니다.

Web3 보안 감사(Smart Contract Auditing) 및 버그바운티 역량 강화를 목표로, 각 레벨의 취약점 원리와 수정 방안을 감사 리포트 형식으로 정리합니다.

## 학습 배경

해군 CERT에서 네트워크 보안 운영 업무를 수행하며 실시간 위협 탐지 및 접근통제 환경을 다뤘습니다. 이 과정에서 온체인 환경은 배포된 코드가 곧 최종 규칙이 되어 사후 대응이 불가능하다는 점에 주목하게 되었고, 이후 Solidity 및 EVM 기반 취약점 패턴을 체계적으로 학습하고 있습니다.

## 진행 현황

| # | 레벨명 | 취약점 카테고리 | 상태 |
|---|--------|-----------------|------|
| 22 | [Dex](./22-dex/README.md) | Price Oracle Manipulation | ✅ 완료 |

> 진행 중인 레벨은 지속적으로 업데이트됩니다.

## 폴더 구조

```
openzeppelin-ethernaut/
├── README.md
├── 22-dex/
│   ├── README.md          # 취약점 분석 및 익스플로잇 로직
│   └── Exploit.t.sol      # Foundry 재현 테스트 (예정)
└── ...
```

## 작성 원칙

각 레벨 문서는 아래 순서로 통일하여 작성합니다.

1. **취약점 요약** — 어떤 종류의 취약점인지 (CWE / OWASP Smart Contract Top 10 기준 분류)
2. **취약한 코드** — 문제가 되는 코드 스니펫
3. **원인 분석** — 왜 취약한지, 정상적인 설계와의 차이
4. **익스플로잇 로직** — 단계별 공격 시퀀스
5. **수정 방안** — 안전한 코드로의 개선 방향

## Contact

- Blog: (hwithJlog 링크)
- GitHub: (프로필 링크)