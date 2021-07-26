from qiskit import QuantumCircuit, ClassicalRegister, QuantumRegister
from qiskit.circuit.library import QFT
from qiskit import execute
from qiskit import Aer
import math

def QPE(oracle, circuit, register, ancilla):

    circuit.h(register)
    circuit.x(ancilla)

    for i in range(len(register)):
        for j in range(2 ** i):
            oracle(circuit, register[i], ancilla)

    qft_dagger(circuit, len(register))


def QPEmeasure(oracle, circuit, register, ancilla, classical_register):
    
    QPE(oracle, circuit, register, ancilla)

    result = circuit.measure(register, classical_register)
    print(circuit)

    simulator = Aer.get_backend('aer_simulator')
    simulation = execute(circuit, simulator, shots=1)
    result = simulation.result()

    counts = result.get_counts(circuit)
    
    for(measured_state, count) in counts.items():
        big_endian_state = measured_state
        print(big_endian_state)
        return int(big_endian_state, 2) / (2 ** len(register))


def qft_dagger(qc, n):
    """n-qubit QFTdagger the first n qubits in circ"""
    # Don't forget the Swaps!
    for qubit in range(n//2):
        qc.swap(qubit, n-qubit-1)
    for j in range(n):
        for m in range(j):
            qc.cp(-math.pi/float(2**(j-m)), m, j)
        qc.h(j)
