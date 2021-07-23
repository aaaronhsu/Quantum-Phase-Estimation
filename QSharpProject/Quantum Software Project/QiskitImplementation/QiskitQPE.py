
from qiskit import QuantumCircuit, ClassicalRegister, QuantumRegister
from qiskit import execute
from qiskit import Aer
import mpmath

def test_1(circuit, register, ancilla):
    qubit= QuantumRegister(5)
    classic= ClassicalRegister(2)
    QPE= QuantumCircuit(qubit, classic)
    
    QPE=circuit.x(qubit[2])
    QPE=circuit.h(qubit[0])
    QPE=circuit.h(qubit[1])
    QPE=circuit.h(qubit[3])
    QPE=circuit.h(qubit[4])
    QPE=circuit.h(qubit[5])

    QPE=circuit.cz(qubit[1], qubit[2], qubit[0])

    def iqft(circuit, qubit, n):
        for i in range(n):
            circuit.h(qubit[i])
            for d in range(i+1, n):
                #t gate
                circuit.t((math.pi/4), qubit[i], qubit[d)
    def iqft(circuit, qubit, n):
        for i in range(n):
            d=(n-1)-i
            for w in range(d):
                circuit.t((math.pi/4), qubit[i], qubit[w])
            circuit.h(qubit[i])
    iqft(QPE, qubit, 2)
    #measure
    QPE.measure(qubit[0}, classic[0])
    QPE.measure(qubit[1], classic[1])
    QPE.measure(qubit[2], classic[2])
    #run
    simulator= Aer.get_backend('aer_simulator')
    simulation= execute(circuit, simulator, shots=1)
    result= simulation.result()


