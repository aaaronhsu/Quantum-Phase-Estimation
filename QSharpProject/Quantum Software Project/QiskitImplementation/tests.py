import unittest

from qiskit import QuantumCircuit, ClassicalRegister, QuantumRegister
from qiskit import execute
from qiskit import Aer
import math

import methods

def oracle1(circuit, control_qubit, ancilla):
        circuit.cp(math.pi/4, control_qubit, ancilla)

class Test_test_1(unittest.TestCase):

    def test_A(self):

        register = QuantumRegister(5)
        ancilla = QuantumRegister(1)
        classical_register = ClassicalRegister(5)
        circuit = QuantumCircuit(register, ancilla, classical_register)
        
        expected_ans = 0.125
        result = methods.QPEmeasure(oracle1, circuit, register, ancilla, classical_register)

        if not (expected_ans - 0.05 < result and result < expected_ans + 0.05):
            self.fail("Incorrect result: " + str(result))

        print("Test passed!")

if __name__ == '__main__':
    unittest.main()
