#!/bin/bash
# =============================================================
# 오픈소스SW응용 3주차 — Git 내부 탐험 스크립트
#
# 이 스크립트는 Git의 내부 구조를 직접 확인합니다.
# 한 단계씩 실행하면서 출력 결과를 관찰하세요.
# =============================================================

set -e

echo "============================================"
echo " Git 내부 탐험 — 3주차 실습"
echo "============================================"
echo ""

# ----------------------------------------------------------
# Step 1: .git 디렉토리 구조 확인
# ----------------------------------------------------------
echo "▶ Step 1: .git 디렉토리 구조"
echo "--------------------------------------------"
echo "ls .git/"
ls .git/
echo ""
echo "💡 objects/에 Git의 모든 데이터가 저장됩니다."
echo "💡 refs/에 branch, tag 포인터가 있습니다."
echo "💡 HEAD가 현재 branch를 가리킵니다."
echo ""

read -p "Enter를 눌러 다음 단계로... "
echo ""

# ----------------------------------------------------------
# Step 2: HEAD 확인 — 현재 branch
# ----------------------------------------------------------
echo "▶ Step 2: HEAD — 지금 어떤 branch에 있는가?"
echo "--------------------------------------------"
echo "cat .git/HEAD"
cat .git/HEAD
echo ""
echo "💡 HEAD는 현재 branch를 가리키는 포인터입니다."
echo ""

read -p "Enter를 눌러 다음 단계로... "
echo ""

# ----------------------------------------------------------
# Step 3: branch 파일 확인 — 40자 해시
# ----------------------------------------------------------
echo "▶ Step 3: Branch — 파일 하나, 해시 하나"
echo "--------------------------------------------"

# HEAD에서 branch 경로 추출
BRANCH_REF=$(cat .git/HEAD | sed 's/ref: //')
echo "Branch 파일: .git/$BRANCH_REF"
echo ""
echo "cat .git/$BRANCH_REF"
cat ".git/$BRANCH_REF"
echo ""
echo "💡 branch는 commit 해시를 담은 40바이트 파일에 불과합니다."
echo "💡 SVN은 전체 디렉토리를 복사했지만, Git은 파일 하나만 생성합니다."
echo ""

read -p "Enter를 눌러 다음 단계로... "
echo ""

# ----------------------------------------------------------
# Step 4: commit 객체 열어보기
# ----------------------------------------------------------
echo "▶ Step 4: Commit 객체 — 스냅샷의 실체"
echo "--------------------------------------------"
echo "git cat-file -p HEAD"
git cat-file -p HEAD
echo ""
echo "💡 tree: 이 시점의 전체 프로젝트 디렉토리 구조"
echo "💡 parent: 이전 commit (첫 commit이면 없음)"
echo "💡 author/committer: 누가, 언제"
echo "💡 commit은 diff(변경분)가 아니라 snapshot(스냅샷)입니다!"
echo ""

read -p "Enter를 눌러 다음 단계로... "
echo ""

# ----------------------------------------------------------
# Step 5: tree 객체 열어보기
# ----------------------------------------------------------
echo "▶ Step 5: Tree 객체 — 디렉토리 구조"
echo "--------------------------------------------"
TREE_HASH=$(git rev-parse HEAD^{tree})
echo "git cat-file -p $TREE_HASH"
git cat-file -p "$TREE_HASH"
echo ""
echo "💡 tree는 '파일 이름 → blob 해시'의 매핑 목록입니다."
echo "💡 Linux의 디렉토리 엔트리(inode 매핑)와 같은 구조입니다."
echo ""

read -p "Enter를 눌러 다음 단계로... "
echo ""

# ----------------------------------------------------------
# Step 6: blob 객체 열어보기
# ----------------------------------------------------------
echo "▶ Step 6: Blob 객체 — 파일 내용 그 자체"
echo "--------------------------------------------"
# README.md의 blob 해시 찾기
BLOB_HASH=$(git rev-parse HEAD:README.md 2>/dev/null || git rev-parse HEAD:calculator.py)
BLOB_FILE="README.md"
if ! git rev-parse HEAD:README.md >/dev/null 2>&1; then
    BLOB_FILE="calculator.py"
fi
echo "git cat-file -p $BLOB_HASH | head -5"
git cat-file -p "$BLOB_HASH" | head -5
echo "..."
echo ""
echo "💡 blob은 파일 이름을 포함하지 않습니다. 순수한 내용만 담습니다."
echo "💡 같은 내용의 파일이 10개 있어도 blob은 1개만 저장됩니다."
echo ""

read -p "Enter를 눌러 다음 단계로... "
echo ""

# ----------------------------------------------------------
# Step 7: 해시의 의미 — 내용이 바뀌면 해시가 바뀐다
# ----------------------------------------------------------
echo "▶ Step 7: SHA-1 해시 — 무결성 보장"
echo "--------------------------------------------"
echo "# 같은 내용 → 같은 해시"
echo "echo 'Hello Git' | git hash-object --stdin"
echo "$(echo 'Hello Git' | git hash-object --stdin)"
echo ""
echo "# 1글자만 바꿔도 → 완전히 다른 해시"
echo "echo 'Hello Git!' | git hash-object --stdin"
echo "$(echo 'Hello Git!' | git hash-object --stdin)"
echo ""
echo "💡 내용이 1바이트만 바뀌어도 해시가 완전히 달라집니다."
echo "💡 이것이 Git의 무결성 보장 원리입니다 (Merkle Tree)."
echo ""

# ----------------------------------------------------------
# 정리
# ----------------------------------------------------------
echo "============================================"
echo " 탐험 완료!"
echo "============================================"
echo ""
echo "  commit ──→ tree ──→ blob"
echo "  (스냅샷)   (디렉토리)  (파일 내용)"
echo ""
echo "  branch = 40바이트 해시 포인터"
echo "  HEAD   = 현재 branch를 가리키는 포인터"
echo ""
echo "  Git의 모든 것은 .git/ 디렉토리 안에 있습니다."
echo "============================================"
