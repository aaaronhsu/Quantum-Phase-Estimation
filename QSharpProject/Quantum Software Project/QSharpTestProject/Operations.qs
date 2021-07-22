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
        oracle : (Qubit[]) => Unit is Adj + Ctl,
        register : Qubit[],
        ancilla : Qubit[]
    ) : Unit is Adj
    {
        ApplyToEachA(H, register);
        ApplyToEachA(X, ancilla);

        for i in 0 .. Length(register) - 1 {
            for j in 1 .. (2 ^ i) {
                Controlled oracle([register[i]], ancilla);
            }
        }
        
        Adjoint QFTLE(LittleEndian(register));
    }

    operation QPEmeasure (
        oracle : (Qubit[]) => Unit is Adj + Ctl,
        register : Qubit[],
        ancilla : Qubit[]
    ) : Double
    {
        QPE(oracle, register, ancilla);

        DumpRegister((), ancilla + register);

        let result = IntAsDouble(MeasureInteger(LittleEndian(register)));

        Message($"{result} / {IntAsDouble(2 ^ Length(register))}");

        return result / IntAsDouble((2 ^ Length(register)));
    }
}