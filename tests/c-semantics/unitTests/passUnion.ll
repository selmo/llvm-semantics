; ModuleID = './passUnion.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.U = type { i8 }

@u = global %union.U { i8 5 }, align 1

; Function Attrs: nounwind uwtable
define zeroext i8 @f(i8 %x.coerce) #0 {
  %x = alloca %union.U, align 1
  %1 = getelementptr %union.U* %x, i32 0, i32 0
  store i8 %x.coerce, i8* %1
  %2 = bitcast %union.U* %x to i8*
  %3 = load i8* %2, align 1
  ret i8 %3
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  %2 = load i8* getelementptr inbounds (%union.U* @u, i32 0, i32 0)
  %3 = call zeroext i8 @f(i8 %2)
  %4 = zext i8 %3 to i32
  ret i32 %4
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.5-1ubuntu1 (trunk) (based on LLVM 3.5)"}
