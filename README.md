# openzeppelin-ethernaut

[Ethernaut](https://ethernaut.openzeppelin.com/) 워게임의 스마트 컨트랙트 취약점 분석 및 익스플로잇

Web3 기본기 및 버그바운티 역량 강화를 목표를 잡고  
취약점 원리와 수정 방안 리뷰가 목적인 레포입니다.


## 진행 현황

| 22 | [Dex](https://github.com/hwithjinsoo/openzeppelin-ethernaut-writeup/blob/main/22-dev) 
| 01 | [Fallback](https://github.com/hwithjinsoo/openzeppelin-ethernaut-writeup/tree/main/01-fallback) 
| 02 | [Fallout](https://github.com/hwithjinsoo/openzeppelin-ethernaut-writeup/tree/main/02-fallout) 
| 04 | [Telephone](https://github.com/hwithjinsoo/openzeppelin-ethernaut-writeup/tree/main/04-telephone) 


## 폴더 구조

```
openzeppelin-ethernaut/
├── README.md
├── 22-dex/
│   ├── contract.sol       # 전체 컨트랙트 코드
│   └── README.md          # 취약점 분석 및 익스플로잇 로직
└── ...
```

## 작성 원칙

각 레벨 문서는 아래 순서로 통일하여 작성합니다.

1. **취약점 요약** — 어떤 종류의 취약점인지, 문제 핵심 개념 소개
2. **사전 지식** *(필요 시)* — 문제 이해에 필요한 배경 지식
3. **취약 코드** — 문제가 되는 코드 스니펫
4. **원인 분석** — 왜 취약한지, 정상적인 설계와의 차이
5. **익스플로잇 로직** — 단계별 공격 시퀀스
6. **수정 방안** — 취약한 코드 개선 
7. **CWE 분류** — 해당되는 CWE,CVE 번호 및 명칭

## Contact

- Blog: (hwithJlog 링크)
- GitHub: (프로필 링크)