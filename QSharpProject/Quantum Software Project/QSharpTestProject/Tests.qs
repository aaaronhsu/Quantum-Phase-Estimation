﻿namespace Quantum.QSharpTestProject {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

    open QSharpTestProject;

    operation oracle1 (ancilla : Qubit[]) : Unit is Adj + Ctl
    {
        for qubit in ancilla {
            T(qubit);
        }
    }

    @Test("QuantumSimulator")
    operation Oracle1Test () : Unit
    {
        use (register, ancilla) = (Qubit[5], Qubit[1]);
        let estimatedAnswer = 1.0 / 8.0;

        for i in 1 .. 3
        {
            let ret = QPEmeasure(oracle1, register, ancilla);

            if not (estimatedAnswer - 0.05 < ret and ret < estimatedAnswer + 0.05)
            {
                fail $"Measured {ret}";
            }

            ResetAll(register + ancilla);
        }
    }

    operation oracle2 (ancilla : Qubit[]) : Unit is Adj + Ctl
    {
        for qubit in ancilla {
            R1(2.0 * PI() / 3.0, qubit);
        }
    }

    @Test("QuantumSimulator")
    operation Oracle2Test () : Unit
    {
        use (register, ancilla) = (Qubit[10], Qubit[1]);
        let estimatedAnswer = 1.0 / 3.0;

        for i in 1 .. 3
        {
            let ret = QPEmeasure(oracle2, register, ancilla);

            if not (estimatedAnswer - 0.05 < ret and ret < estimatedAnswer + 0.05)
            {
                fail $"Measured {ret}";
            }

            ResetAll(register + ancilla);
        }
    }

    operation oracle3 (ancilla : Qubit[]) : Unit is Adj + Ctl
    {
        for qubit in ancilla {
            S(qubit);
        }
    }

    @Test("QuantumSimulator")
    operation Oracle3Test () : Unit
    {
        use (register, ancilla) = (Qubit[10], Qubit[1]);
        let estimatedAnswer = 0.25;

        for i in 1 .. 3
        {
            let ret = QPEmeasure(oracle3, register, ancilla);

            if not (estimatedAnswer - 0.05 < ret and ret < estimatedAnswer + 0.05)
            {
                fail $"Measured {ret}";
            }

            ResetAll(register + ancilla);
        }
    }

    operation oracle4 (ancilla : Qubit[]) : Unit is Adj + Ctl
    {
        for qubit in ancilla {
            R1(PI() / 25.0, qubit);
        }
    }

    @Test("QuantumSimulator")
    operation Oracle4Test () : Unit
    {
        use (register, ancilla) = (Qubit[10], Qubit[1]);
        let estimatedAnswer = 0.02;

        for i in 1 .. 3
        {
            let ret = QPEmeasure(oracle4, register, ancilla);

            if not (estimatedAnswer - 0.05 < ret and ret < estimatedAnswer + 0.05)
            {
                fail $"Measured {ret}";
            }

            ResetAll(register + ancilla);
        }
    }

    


    // two qubit gates
    operation oracle5 (ancilla : Qubit[]) : Unit is Adj + Ctl
    {
        // this will rotate by pi if ancilla is |11>
        Controlled R1(ancilla[0 .. 0], (PI(), ancilla[1]));
    }

    @Test("QuantumSimulator")
    operation Oracle5Test () : Unit
    {
        use (register, ancilla) = (Qubit[10], Qubit[2]);
        let estimatedAnswer = 0.5;

        for i in 1 .. 3
        {
            let ret = QPEmeasure(oracle5, register, ancilla);

            if not (estimatedAnswer - 0.05 < ret and ret < estimatedAnswer + 0.05)
            {
                fail $"Measured {ret}";
            }

            ResetAll(register + ancilla);
        }
    }
}
