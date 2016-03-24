// Copyright (c) 2013-2015 K Team. All Rights Reserved.
requires "llvm-syntax.k"
requires "llvm-abstractsyntax.k"
requires "llvm-settings.k"
requires "llvm-helpers.k"
requires "llvm-standard-library-syntax.k"
requires "llvm-syscalls-syntax.k"
requires "llvm-configuration.k"

module LLVM-GLOBALS
    imports LLVM-SYNTAX
    imports LLVM-ABSTRACTSYNTAX
    imports LLVM-SETTINGS
    imports LLVM-HELPERS
    imports LLVM-STANDARD-LIBRARY-SYNTAX
    imports LLVM-SYSCALLS-SYNTAX
    imports LLVM-CONFIGURATION

    syntax KItem ::= preInit(K, K, K) [strict(2)]

    //for the pointer type of global variable.
    rule
        <k> globalVariable(X:SymbolicValueRef, L:Set, 'pointerType(TyK:K,, Ad:K), Init:K)
            => preInit(X, alloca(TyK:K, 1, 'alignEmpty(.KList))
                                 , initializer('pointerType(TyK:K,, Ad:K),Init))
        ...</k>
        <currentModifiers> _ => L </currentModifiers>

    //for the array type of global variable.
    rule
        <k> globalVariable(X:SymbolicValueRef, L:Set
                , arrayTypeValue(TyK:KResult,Size:Int), Init:K)
            => preInit(X, alloca(TyK, Size, 'alignEmpty(.KList))
                                  , initializer(arrayTypeValue(TyK,Size),Init))
        ...</k>
        <currentModifiers> _ => L </currentModifiers>

    //for the struct type of global variable.
    rule
        <k> globalVariable(X:SymbolicValueRef, L:Set
                , structTypeValue(TyK:KResult), Init:K)
            => preInit(X, alloca(TyK, 1, 'alignEmpty(.KList))
                                  , initializer(structTypeValue(TyK),Init))
        ...</k>
        <currentModifiers> _ => L </currentModifiers>

    //for the function type of global variable - an error.
    rule
        <k> globalVariable(X:SymbolicValueRef, L:Set
                , functionTypeValue(TyK:K, K':K), Init:K) ~> K
            => .K
        </k>
        <output>... .List => ListItem("error: invalid type for global variable") </output>

    rule
        <k> preInit(X:SymbolicValueRef, Loc:Loc, initializer(TK:K, K:K)) => .K ...</k>
        <savedGlobals>... .K => store(TK:K, K:K, Loc) </savedGlobals>
        <globalRegisters> M:Map => M[X <- Loc] </globalRegisters>

    rule <k> initGlobals => initBuiltins(ListItem(name("@__libc_start_main_0")) ListItem(name("@__libc_start_main_2"))
                                         ListItem(name("@exit")) ListItem(name("@llvm.memcpy.")) ListItem(name("@llvm.memset."))
                                         ListItem(name("@llvm.lifetime.start")) ListItem(name("@llvm.lifetime.end"))
                                         ListItem(name("@llvm.va_start")) ListItem(name("@llvm.va_copy")) ListItem(name("@llvm.va_end"))
                                         ListItem(name("@__syscall")) ListItem(name("@vprintf"))) ~> K:K ...</k>
        <savedGlobals> K:K => .K </savedGlobals>

    rule initBuiltins(.List) => .K
    rule <k> initBuiltins(ListItem(X:SymbolicValueRef) Ls:List => Ls) ...</k>
         <globalRegisters> M:Map => M[X <- funptr(X)] </globalRegisters>














endmodule