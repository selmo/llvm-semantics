; ModuleID = './960801-1.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @f() #0 {
  %l2 = alloca i64, align 8
  %us = alloca i16, align 2
  %ul = alloca i64, align 8
  %s2 = alloca i16, align 2
  store i16 -1, i16* %s2, align 2
  store i64 -1, i64* %l2, align 8
  store i16 -1, i16* %us, align 2
  store i64 65535, i64* %ul, align 8
  %1 = load i64* %ul, align 8
  %2 = trunc i64 %1 to i32
  ret i32 %2
}

; Function Attrs: nounwind uwtable
define i64 @g() #0 {
  %l2 = alloca i64, align 8
  %us = alloca i16, align 2
  %ul = alloca i64, align 8
  %s2 = alloca i16, align 2
  store i16 -1, i16* %s2, align 2
  store i64 -1, i64* %l2, align 8
  store i16 -1, i16* %us, align 2
  store i64 65535, i64* %ul, align 8
  %1 = load i64* %ul, align 8
  ret i64 %1
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  %2 = call i32 @f()
  %3 = icmp ne i32 %2, 65535
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  call void @abort() #2
  unreachable

; <label>:5                                       ; preds = %0
  %6 = call i64 @g()
  %7 = icmp ne i64 %6, 65535
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %5
  call void @abort() #2
  unreachable

; <label>:9                                       ; preds = %5
  call void @exit(i32 0) #2
  unreachable
                                                  ; No predecessors!
  %11 = load i32* %1
  ret i32 %11
}

; Function Attrs: noreturn nounwind
declare void @abort() #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.5-1ubuntu1 (trunk) (based on LLVM 3.5)"}
