"""
오픈소스SW응용 3주차 — 기본 계산기 모듈

이 파일은 2인 PR 협업 실습의 시작점입니다.
실습에서 multiply, divide 등 새 함수를 추가합니다.
"""

import math


def add(a: float, b: float) -> float:
    """두 수를 더한다."""
    return a + b


def subtract(a: float, b: float) -> float:
    """두 수를 뺀다."""
    return a - b


def multiply(a: float, b: float) -> float:
    """두 수를 곱한다."""
    return a * b


def divide(a: float, b: float) -> float:
    """두 수를 나눈다. 0으로 나누면 ValueError를 발생시킨다."""
    if b == 0:
        raise ValueError("0으로 나눌 수 없습니다")
    return a / b


def power(base: float, exp: float) -> float:
    """밑과 지수를 받아 거듭제곱을 계산한다."""
    return math.pow(base, exp)


def sqrt(x: float) -> float:
    """제곱근을 계산한다. 음수 입력 시 ValueError를 발생시킨다."""
    if x < 0:
        raise ValueError("음수의 제곱근은 계산할 수 없습니다")
    return math.sqrt(x)
