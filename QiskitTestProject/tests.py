import unittest

from qiskit import QuantumCircuit, ClassicalRegister, QuantumRegister
from qiskit import execute
from qiskit import Aer
import math

import methods

def oracle1(circuit, control_qubit, ancilla):
    circuit.cp(math.pi * 2 / 4.0, control_qubit, ancilla)

def oracle2(circuit, control_qubit, ancilla):
    circuit.cp(math.pi * 2 / 3.0, control_qubit, ancilla)

class Test_test_1(unittest.TestCase):

    def test_A(self):

        register = QuantumRegister(4)
        ancilla = QuantumRegister(1)
        classical_register = ClassicalRegister(4)
        circuit = QuantumCircuit(register, ancilla, classical_register)
        
        expected_ans = 1/4
        results = methods.QPEmeasure(oracle1, circuit, register, ancilla, classical_register)

        failed_cases = 0

        for i in results:
            if not (expected_ans - 0.05 < i and i < expected_ans + 0.05):
                failed_cases += 1

        print("Test 1: " + str(len(results) - failed_cases) + "/" + str(len(results)) + " cases passed!")

    def test_B(self):

        register = QuantumRegister(4)
        ancilla = QuantumRegister(1)
        classical_register = ClassicalRegister(4)
        circuit = QuantumCircuit(register, ancilla, classical_register)
        
        expected_ans = 1/3
        results = methods.QPEmeasure(oracle2, circuit, register, ancilla, classical_register)

        failed_cases = 0

        for i in results:
            if not (expected_ans - 0.05 < i and i < expected_ans + 0.05):
                failed_cases += 1

        print("Test 2: " + str(len(results) - failed_cases) + "/" + str(len(results)) + " cases passed!")


if __name__ == '__main__':
    unittest.main()
