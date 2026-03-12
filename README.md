# 오픈소스SW응용 3주차 — Git + GitHub Flow 실습

**연세대학교 글로벌인재대학 응용정보공학 | 오픈소스SW응용 (GAI4008-01-00)**

## 실습 목표

2인 1조로 GitHub Flow의 전체 사이클을 체험한다:

1. **Git 내부 탐험** — blob, tree, commit 객체를 직접 열어본다
2. **GitHub Flow** — Branch → Commit → PR → Review → Merge
3. **opencode CLI** — 터미널에서 AI와 함께 코드를 작성한다
4. **PR 코드 리뷰** — 상대방의 PR에 리뷰 댓글을 남긴다

## 파일 구조

```
.
├── calculator.py          # 기본 계산기 (add, subtract)
├── test_calculator.py     # 테스트 코드 (pytest)
├── git_explore.sh         # Git 내부 탐험 스크립트
└── README.md
```

## 환경 설정

```bash
# Python 3.8+
pip install pytest

# opencode CLI (택 1)
brew install opencode-ai/tap/opencode          # macOS
curl -fsSL https://opencode.ai/install | bash   # Linux / WSL

# GitHub CLI
brew install gh   # macOS
# 또는 https://cli.github.com/
```

## 실습 순서

### Part 1: Git 내부 탐험 (개인, 15분)

```bash
bash git_explore.sh
```

스크립트를 따라가면서 blob, tree, commit 객체를 직접 확인한다.

### Part 2: 2인 PR 협업 (페어, 40분)

#### Round 1 — A가 소유자, B가 기여자

1. **A**: 이 저장소를 fork 또는 clone → collaborator로 B 추가
2. **B**: feature branch 생성 → `calculator.py`에 `multiply`, `divide` 추가
3. **B**: PR 생성 → A가 리뷰 → Squash Merge

#### Round 2 — 역할 교대

1. **B**: 새 기능 요청 (Issue 생성)
2. **A**: feature branch에서 기능 구현 → PR 생성
3. **B**: 리뷰 → Merge

### Part 3: opencode로 기능 추가 (선택, 15분)

```bash
git checkout -b feature/advanced-ops
opencode
> "calculator.py에 power(거듭제곱)와 sqrt(제곱근) 함수를 추가해줘.
   math 모듈을 사용하고, 음수 sqrt는 ValueError를 발생시켜.
   test_calculator.py에 테스트도 추가."
```

## 실습 체크리스트

- [ ] `git cat-file -p HEAD`로 commit 객체 확인
- [ ] feature branch에서 작업 → PR 생성
- [ ] 상대방 PR에 리뷰 댓글 1개 이상
- [ ] Squash Merge 실행
- [ ] (보너스) merge conflict 해결

## 과제 제출

GitHub Discussion에 아래 내용을 작성한다 (500자 이상):

1. commit 객체에 포함된 정보와 "스냅샷"의 의미
2. branch 파일(`.git/refs/heads/main`)의 내용
3. opencode가 생성한 코드를 수정했다면, 무엇을 왜 바꿨는가
4. 상대방 PR을 리뷰할 때 가장 먼저 확인한 것

**마감**: 4주차 수업 전일 23:59
