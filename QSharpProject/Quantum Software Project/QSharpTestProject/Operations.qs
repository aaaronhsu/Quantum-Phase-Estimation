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

        DumpRegister((), register);

        let result = IntAsDouble(MeasureInteger(LittleEndian(register)));

        Message($"{result} / {IntAsDouble(2 ^ Length(register))}");

        return result / IntAsDouble((2 ^ Length(register)));
    }

    operation QPE7 (
        oracle : (Qubit[]) => Unit is Adj + Ctl,
        register : Qubit[],
        ancilla : Qubit[]
    ) : Double
    {
        ApplyToEachA(H, register);
        
        H(ancilla[0]);
        CNOT(ancilla[0], ancilla[1]);
        CNOT(ancilla[0], ancilla[2]);

        for i in 0 .. Length(register) - 1 {
            for j in 1 .. (2 ^ i) {
                Controlled oracle([register[i]], ancilla);

                Controlled Z([ancilla[0]], ancilla[1]);
                H(ancilla[2]);
                CCNOT(ancilla[0], ancilla[1], ancilla[2]);
                H(ancilla[2]);
            }
        }
        
        Adjoint QFTLE(LittleEndian(register));

        DumpRegister((), register);

        let result = IntAsDouble(MeasureInteger(LittleEndian(register)));

        Message($"{result} / {IntAsDouble(2 ^ Length(register))}");

        return result / IntAsDouble((2 ^ Length(register)));
    }
}