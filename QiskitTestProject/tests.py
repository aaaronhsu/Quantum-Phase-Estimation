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

def oracle3(circuit, control_qubit, ancilla):
    circuit.cp(math.pi / 25.0, control_qubit, ancilla)

def oracle4(circuit, control_qubit, ancilla):
    circuit.cp(math.pi / 100.0, control_qubit, ancilla)

class Test_test_1(unittest.TestCase):

    # because expected answer is a power of 2, all pass
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

    # expected answer is not a power of 2, estimation involved
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

    # expected answer is not a power of 2, estimation involved
    def test_C(self):

        register = QuantumRegister(4)
        ancilla = QuantumRegister(1)
        classical_register = ClassicalRegister(4)
        circuit = QuantumCircuit(register, ancilla, classical_register)
        
        expected_ans = 0.02
        results = methods.QPEmeasure(oracle3, circuit, register, ancilla, classical_register)

        failed_cases = 0

        for i in results:
            if not (expected_ans - 0.05 < i and i < expected_ans + 0.05):
                failed_cases += 1

        print("Test 3: " + str(len(results) - failed_cases) + "/" + str(len(results)) + " cases passed!")

    # expected answer is a very small value, not enough qubits for accuracy
    def test_D(self):

        register = QuantumRegister(5)
        ancilla = QuantumRegister(1)
        classical_register = ClassicalRegister(5)
        circuit = QuantumCircuit(register, ancilla, classical_register)
        
        expected_ans = 0.005
        results = methods.QPEmeasure(oracle4, circuit, register, ancilla, classical_register)

        failed_cases = 0

        for i in results:
            if not (expected_ans - 0.005 < i and i < expected_ans + 0.005):
                failed_cases += 1

        print("Test 4: " + str(len(results) - failed_cases) + "/" + str(len(results)) + " cases passed!")

    # expected answer is a very small value, but enough qubits for accuracy
    def test_E(self):

        register = QuantumRegister(10)
        ancilla = QuantumRegister(1)
        classical_register = ClassicalRegister(10)
        circuit = QuantumCircuit(register, ancilla, classical_register)
        
        expected_ans = 0.005
        results = methods.QPEmeasure(oracle4, circuit, register, ancilla, classical_register)

        failed_cases = 0

        for i in results:
            if not (expected_ans - 0.005 < i and i < expected_ans + 0.005):
                failed_cases += 1

        print("Test 5: " + str(len(results) - failed_cases) + "/" + str(len(results)) + " cases passed!")


if __name__ == '__main__':
    unittest.main()
