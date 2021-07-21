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
        use register = Qubit[5];

        let ret = QPEmeasure(oracle1, register);

        if ret != 0.125
        {
            fail $"Measured {ret}";
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

        let ret = QPEmeasure(oracle2, register);

        if ret != 1.0/3.0
        {
            fail $"Measured {ret}";
        }
    }
}
