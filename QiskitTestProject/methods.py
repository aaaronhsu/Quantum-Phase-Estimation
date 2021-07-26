from qiskit import QuantumCircuit, ClassicalRegister, QuantumRegister
from qiskit.circuit.library import QFT
from qiskit import execute
from qiskit import Aer
from qiskit import IBMQ
import math

def QPE(oracle, circuit, register, ancilla):

    # initialize registers
    circuit.h(register)
    circuit.x(ancilla)

    # repeatedly apply oracle
    for i in range(len(register)):
        for j in range(2 ** i):
            oracle(circuit, register[i], ancilla)

    # inverse QFT
    qft_dagger(circuit, len(register))


def QPEmeasure(oracle, circuit, register, ancilla, classical_register, simulation=True):
    
    # call QPE subroutine
    QPE(oracle, circuit, register, ancilla)

    
    result = circuit.measure(register, classical_register)

    # print the circuit diagram
    # print(circuit)

    # initialize output
    result = None

    # run circuit on simulator/quantum computer
    if simulation:
        simulator = Aer.get_backend('aer_simulator')
        simulation = execute(circuit, simulator, shots=1024)
        result = simulation.result()
    else:
        provider = IBMQ.load_account()
        backend = provider.get_backend('ibmq_santiago')
        run = execute(circuit, backend, shots=1024)
        result = run.result()

    # retrieve data and return estimated theta
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
