"""
Homework #3
"""


def factorial():
    print('Введите n')
    n = int(input())
    result = 1
    while n > 1:
        result = result * n
        n = n - 1
    print(result)


def max_from_three():
    print('Введите через пробел три числа')
    result = list(map(int, input().split(" ")))
    print(max(result))


def area_of_rectangle():
    print('Введите через пробел два числа - длины катетов от прямого угла')
    first, second = list(map(int, input().split(" ")))
    print(first * second // 2)


if __name__ == '__main__':
    factorial()
    max_from_three()
    area_of_rectangle()

