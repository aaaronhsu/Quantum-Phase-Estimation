namespace QSharpTestProject {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;


    operation QFT (register : BigEndian) : Unit is Adj + Ctl
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
        arbitraryRotation : Double,
        register : Qubit[]
    ) : Unit
    {
        // setup
        use ancilla = Qubit();

        ApplyToEach(H, register);
        X(ancilla);

        // repeated rotations
        mutable repetitions = 1;

        for cqubit in register
        {
            for i in 1 .. repetitions
            {
                Controlled P(PI()/4, cqubit, ancilla);
            }
            set repetitions = repetitions * 2;
        }

        Adjoint QFT(BigEndian(register));
    }
}
