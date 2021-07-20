namespace Quantum.QSharpTestProject {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    open QSharpTestProject;

    operation oracle1 (controlQubit : Qubit, ancilla : Qubit) : Unit
    {
        Controlled T([controlQubit], ancilla);
    }

    @Test("QuantumSimulator")
    operation Oracle1Test () : Unit
    {
        use register = Qubit[10];

        let ret = QPEmeasure(oracle1, register);

        if ret != 0.125
        {
            fail $"Measured {ret}";
        }
    }
}
