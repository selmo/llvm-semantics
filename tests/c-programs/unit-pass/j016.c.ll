; ModuleID = './j016.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define void @f(i32 %n, i32* %a) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32*, align 8
  store i32 %n, i32* %1, align 4
  store i32* %a, i32** %2, align 8
  %3 = load i32, i32* %1, align 4
  %4 = zext i32 %3 to i64
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %a = alloca [5 x i32], align 16
  %b = alloca [5 x i32]*, align 8
  store i32 0, i32* %1
  %2 = bitcast [5 x i32]* %a to i8*
  call void @llvm.memset.p0i8.i64(i8* %2, i8 0, i64 20, i32 16, i1 false)
  store [5 x i32]* %a, [5 x i32]** %b, align 8
  %3 = load [5 x i32]*, [5 x i32]** %b, align 8
  %4 = bitcast [5 x i32]* %3 to i32*
  call void @f(i32 5, i32* %4)
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.7.1-svn253571-1~exp1 (branches/release_37) (based on LLVM 3.7.1)"}
