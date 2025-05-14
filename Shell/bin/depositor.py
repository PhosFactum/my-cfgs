#!/usr/bin/env python
import click


# Printing function
def print_parameters(amount, term, rate):
    print(f"Remained term: {term} ===> Amount = {amount}")

    if term == 0:
        print(f"\nFinal amount = {amount}")


# Calculating compount interest
def calc_compound_interest(amount, term, rate):
    frate = 1 + (rate / 100)
    print(f"Rate = {rate}% ({frate})\n")
    rate = 1 + (rate / 100)

    while term > 0:
        amount = int(amount * rate)
        term -= 1
        print_parameters(amount, term, rate)


# Main deposit function
@click.command()
@click.argument("amount", type=int, required=True)
@click.argument("term", type=int, required=True)
@click.argument("rate", type=int, required=True)
def deposit(amount, term, rate):
    """Info: \n
    This script helps to calculate the compound interest for a deposit,
    knowing the amount (sum), term (years) and rate (integer percentage). \t
    Capitalization counts yearly. \n


    Syntax: \n
    `python depostior.py <amount> <term> <rate>` \n

    Example: \n
    `python depositor.py 10000 3 10` \n
    """
    print("Original amount =", amount)
    calc_compound_interest(amount, term, rate)

if __name__ == "__main__":
    deposit()