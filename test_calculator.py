"""
오픈소스SW응용 3주차 — 계산기 테스트

실행: pytest test_calculator.py -v
"""

import pytest
from calculator import add, subtract, multiply, divide, power, sqrt


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


class TestMultiply:
    def test_positive_numbers(self):
        assert multiply(2, 3) == 6

    def test_negative_numbers(self):
        assert multiply(-2, -3) == 6

    def test_with_zero(self):
        assert multiply(5, 0) == 0

    def test_float(self):
        assert multiply(1.5, 2.0) == 3.0


class TestDivide:
    def test_positive_numbers(self):
        assert divide(6, 3) == 2.0

    def test_negative_result(self):
        assert divide(5, -2) == -2.5

    def test_zero_dividend(self):
        assert divide(0, 5) == 0.0

    def test_divide_by_zero(self):
        with pytest.raises(ValueError):
            divide(5, 0)


class TestPower:
    def test_positive_exponent(self):
        assert power(2, 3) == 8.0

    def test_zero_exponent(self):
        assert power(5, 0) == 1.0

    def test_negative_exponent(self):
        assert power(2, -2) == 0.25

    def test_negative_base(self):
        assert power(-2, 3) == -8.0

    def test_float_base(self):
        assert power(2.0, 2.0) == 4.0


class TestSqrt:
    def test_perfect_square(self):
        assert sqrt(9) == 3.0

    def test_zero(self):
        assert sqrt(0) == 0.0

    def test_float(self):
        assert sqrt(2.0) ** 2 == pytest.approx(2.0)

    def test_negative_raises_error(self):
        with pytest.raises(ValueError):
            sqrt(-4)
