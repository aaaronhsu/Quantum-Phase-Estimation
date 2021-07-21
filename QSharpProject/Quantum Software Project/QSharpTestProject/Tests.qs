namespace Quantum.QSharpTestProject {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

    open QSharpTestProject;

    operation oracle1 (ancilla : Qubit) : Unit is Ctl
    {
        T(ancilla);
    }

    @Test("QuantumSimulator")
    operation Oracle1Test () : Unit
    {
        use register = Qubit[10];
        let estimatedAnswer = 1.0 / 8.0;

        for i in 1 .. 3
        {
            let ret = QPEmeasure(oracle1, register);

            if not (estimatedAnswer - 0.05 < ret and ret < estimatedAnswer + 0.05)
            {
                fail $"Measured {ret}";
            }

            ResetAll(register);
        }
    }

    operation oracle2 (ancilla : Qubit) : Unit is Ctl
    {
        R1(2.0 * PI() / 3.0, ancilla);
    }

    @Test("QuantumSimulator")
    operation Oracle2Test () : Unit
    {
        use register = Qubit[10];
        let estimatedAnswer = 1.0 / 3.0;

        for i in 1 .. 3
        {
            let ret = QPEmeasure(oracle2, register);

            if not (estimatedAnswer - 0.05 < ret and ret < estimatedAnswer + 0.05)
            {
                fail $"Measured {ret}";
            }

            ResetAll(register);
        }
    }

    operation oracle3 (ancilla : Qubit) : Unit is Ctl
    {
        S(ancilla);
    }

    @Test("QuantumSimulator")
    operation Oracle3Test () : Unit
    {
        use register = Qubit[10];
        let estimatedAnswer = 0.25;

        for i in 1 .. 3
        {
            let ret = QPEmeasure(oracle3, register);

            if not (estimatedAnswer - 0.05 < ret and ret < estimatedAnswer + 0.05)
            {
                fail $"Measured {ret}";
            }

            ResetAll(register);
        }
    }

    operation oracle4 (ancilla : Qubit) : Unit is Ctl
    {
        R1(PI() / 25.0, ancilla);
    }

    @Test("QuantumSimulator")
    operation Oracle4Test () : Unit
    {
        use register = Qubit[10];
        let estimatedAnswer = 0.02;

        for i in 1 .. 3
        {
            let ret = QPEmeasure(oracle4, register);

            if not (estimatedAnswer - 0.05 < ret and ret < estimatedAnswer + 0.05)
            {
                fail $"Measured {ret}";
            }

            ResetAll(register);
        }
    }



    // non-rotation gates
    operation oracle5 (ancilla : Qubit) : Unit is Ctl
    {
        H(ancilla);
    }

    @Test("QuantumSimulator")
    operation Oracle5Test () : Unit
    {
        use register = Qubit[3];
        let estimatedAnswer = 0.5;

        for i in 1 .. 3
        {
            let ret = QPEmeasure(oracle5, register);

            if not (estimatedAnswer - 0.05 < ret and ret < estimatedAnswer + 0.05)
            {
                fail $"Measured {ret}";
            }

            ResetAll(register);
        }
    }
}
