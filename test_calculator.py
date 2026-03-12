"""
오픈소스SW응용 3주차 — 계산기 테스트

실행: pytest test_calculator.py -v
"""

from calculator import add, subtract


class TestAdd:
    def test_positive_numbers(self):
        assert add(2, 3) == 5

    def test_negative_numbers(self):
        assert add(-1, -1) == -2

    def test_zero(self):
        assert add(0, 0) == 0

    def test_float(self):
        assert add(1.5, 2.5) == 4.0


class TestSubtract:
    def test_positive_numbers(self):
        assert subtract(5, 3) == 2

    def test_negative_result(self):
        assert subtract(3, 5) == -2

    def test_zero(self):
        assert subtract(5, 5) == 0

    def test_float(self):
        assert subtract(3.5, 1.5) == 2.0
