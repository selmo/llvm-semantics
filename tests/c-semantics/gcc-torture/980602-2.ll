; ModuleID = './980602-2.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.anon = type { [4 x i8] }

@t = common global %struct.anon zeroinitializer, align 4

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1
  %2 = load i32* bitcast (%struct.anon* @t to i32*), align 4
  %3 = and i32 %2, 1073741823
  %4 = add i32 %3, 1
  %5 = load i32* bitcast (%struct.anon* @t to i32*), align 4
  %6 = and i32 %4, 1073741823
  %7 = and i32 %5, -1073741824
  %8 = or i32 %7, %6
  store i32 %8, i32* bitcast (%struct.anon* @t to i32*), align 4
  %9 = icmp ne i32 %3, 0
  br i1 %9, label %11, label %10

; <label>:10                                      ; preds = %0
  call void @exit(i32 0) #2
  unreachable

; <label>:11                                      ; preds = %0
  call void @abort() #2
  unreachable
                                                  ; No predecessors!
  %13 = load i32* %1
  ret i32 %13
}

; Function Attrs: noreturn nounwind
declare void @exit(i32) #1

; Function Attrs: noreturn nounwind
declare void @abort() #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.5-1ubuntu1 (trunk) (based on LLVM 3.5)"}
