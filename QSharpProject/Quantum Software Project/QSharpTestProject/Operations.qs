namespace QSharpTestProject {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;


    operation QFT (register : BigEndian) : Unit is Adj + Ctl
    {
        // Hint: there are two functions you may want to use here:
        // the first is your implementation of register reversal in Lab 2,
        // Exercise 2.
        // The second is the Microsoft.Quantum.Intrinsic.R1Frac() gate.

        // TODO
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
        t : Int
    ) : Double
    {

    }
}
