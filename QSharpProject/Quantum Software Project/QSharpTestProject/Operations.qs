namespace QSharpTestProject {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Arrays;


    operation QFT2 (register : BigEndian) : Unit is Adj + Ctl
    {
        for i in 0 .. Length(register!) - 1 
        {
            H(register![i]);

            for j in i + 1 .. Length(register!) - 1 
            {
                Controlled R1Frac(([register![j]]), (2, j - i + 1, register![i]));
            }
        }

        for i in 0 .. (Length(register!) / 2) - 1 
        {
            SWAP(register![i], register![Length(register!) - i - 1]);
        }
    }

    operation QPE (
        oracle : (Qubit, Qubit) => Unit,
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
                oracle(controlQubit, ancilla);
            }
            set repetitions = repetitions * 2;
        }
        
        Adjoint QFTLE(LittleEndian(register));
    }

    operation QPEmeasure (
        oracle : (Qubit, Qubit) => Unit,
        register : Qubit[]
    ) : Double
    {
        use ancilla = Qubit();

        QPE(oracle, register, ancilla);

        let result = IntAsDouble(MeasureInteger(LittleEndian(register)));

        Reset(ancilla);

        return result / IntAsDouble((2 ^ Length(register)));
    }
}