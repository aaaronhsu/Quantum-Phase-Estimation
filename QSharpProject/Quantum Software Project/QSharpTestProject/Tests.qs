namespace Quantum.QSharpTestProject {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    open QSharpTestProject;

    operation oracle1 (ancilla : Qubit) : Unit is Ctl
    {
        T(ancilla);
    }

    @Test("QuantumSimulator")
    operation Oracle1Test () : Unit
    {
        use (register, ancilla) = (Qubit[10], Qubit());

        let ret = QPEmeasure(oracle1, register, ancilla);

        ResetAll(register + [ancilla]);

        if ret != 0.125
        {
            fail $"Measured {ret}";
        }
    }
}