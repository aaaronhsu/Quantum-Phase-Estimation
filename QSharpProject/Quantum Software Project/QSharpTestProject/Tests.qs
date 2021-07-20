namespace Quantum.QSharpTestProject {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;

    open QSharpTestProject;

    @Test("QuantumSimulator")
    operation AllocateQubit () : Unit {

        use q = Qubit();
        AssertMeasurement([PauliZ], [q], Zero, "Newly allocated qubit must be in |0> state.");

        Message("Test passed.");
    }

    operation oracle1 (controlQubit : Qubit, ancilla : Qubit) : Unit
    {
        Controlled T([controlQubit], ancilla);
    }

    @Test("QuantumSimulator")
    operation Oracle1Test () : Unit
    {
        use register = Qubit[3];

        let ret = QPEmeasure(oracle1, register);

        Message($"Measured {ret}");

        ResetAll(register);

        AssertAllZero(register);
    }
}
