namespace QSharpTestProject {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Arrays;

    operation QPE (
        oracle : (Qubit) => Unit is Ctl,
        register : Qubit[],
        ancilla : Qubit
    ) : Unit
    {
        ApplyToEach(H, register);
        X(ancilla);

        // repeated rotations
        mutable repetitions = 1;

        for controlQubit in register {

            for i in 1 .. repetitions {
                Controlled oracle([controlQubit], ancilla);
            }
            set repetitions = repetitions * 2;
        }
        
        Adjoint QFTLE(LittleEndian(register));
    }

    operation QPEmeasure (
        oracle : (Qubit) => Unit is Ctl,
        register : Qubit[]
    ) : Double
    {
        use ancilla = Qubit();

        QPE(oracle, register, ancilla);

        DumpRegister((), Reversed(register + [ancilla]));

        let result = IntAsDouble(MeasureInteger(LittleEndian(register)));

        Reset(ancilla);

        return result / IntAsDouble((2 ^ Length(register)));
    }
}