; ModuleID = './va-arg-9.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@to_hex.hex = internal global [17 x i8] c"0123456789abcdef\00", align 16
@.str = private unnamed_addr constant [17 x i8] c"0123456789abcdef\00", align 1

; Function Attrs: nounwind uwtable
define i32 @to_hex(i32 %a) #0 {
  %1 = alloca i32, align 4
  store i32 %a, i32* %1, align 4
  %2 = load i32, i32* %1, align 4
  %3 = icmp ugt i32 %2, 15
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  call void @abort() #4
  unreachable

; <label>:5                                       ; preds = %0
  %6 = load i32, i32* %1, align 4
  %7 = zext i32 %6 to i64
  %8 = getelementptr inbounds [17 x i8], [17 x i8]* @to_hex.hex, i32 0, i64 %7
  %9 = load i8, i8* %8, align 1
  %10 = sext i8 %9 to i32
  ret i32 %10
}

; Function Attrs: noreturn nounwind
declare void @abort() #1

; Function Attrs: nounwind uwtable
define void @fap(i32 %i, i8* %format, %struct.__va_list_tag* %ap) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %3 = alloca %struct.__va_list_tag*, align 8
  store i32 %i, i32* %1, align 4
  store i8* %format, i8** %2, align 8
  store %struct.__va_list_tag* %ap, %struct.__va_list_tag** %3, align 8
  %4 = load i8*, i8** %2, align 8
  %5 = call i64 @strlen(i8* %4)
  %6 = load i32, i32* %1, align 4
  %7 = sub nsw i32 16, %6
  %8 = sext i32 %7 to i64
  %9 = icmp ne i64 %5, %8
  br i1 %9, label %10, label %11

; <label>:10                                      ; preds = %0
  call void @abort() #4
  unreachable

; <label>:11                                      ; preds = %0
  br label %12

; <label>:12                                      ; preds = %42, %11
  %13 = load i8*, i8** %2, align 8
  %14 = load i8, i8* %13, align 1
  %15 = icmp ne i8 %14, 0
  br i1 %15, label %16, label %43

; <label>:16                                      ; preds = %12
  %17 = load i8*, i8** %2, align 8
  %18 = getelementptr inbounds i8, i8* %17, i32 1
  store i8* %18, i8** %2, align 8
  %19 = load i8, i8* %17, align 1
  %20 = sext i8 %19 to i32
  %21 = load %struct.__va_list_tag*, %struct.__va_list_tag** %3, align 8
  %22 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 0
  %23 = load i32, i32* %22
  %24 = icmp ule i32 %23, 40
  br i1 %24, label %25, label %31

; <label>:25                                      ; preds = %16
  %26 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 3
  %27 = load i8*, i8** %26
  %28 = getelementptr i8, i8* %27, i32 %23
  %29 = bitcast i8* %28 to i32*
  %30 = add i32 %23, 8
  store i32 %30, i32* %22
  br label %36

; <label>:31                                      ; preds = %16
  %32 = getelementptr inbounds %struct.__va_list_tag, %struct.__va_list_tag* %21, i32 0, i32 2
  %33 = load i8*, i8** %32
  %34 = bitcast i8* %33 to i32*
  %35 = getelementptr i8, i8* %33, i32 8
  store i8* %35, i8** %32
  br label %36

; <label>:36                                      ; preds = %31, %25
  %37 = phi i32* [ %29, %25 ], [ %34, %31 ]
  %38 = load i32, i32* %37
  %39 = call i32 @to_hex(i32 %38)
  %40 = icmp ne i32 %20, %39
  br i1 %40, label %41, label %42

; <label>:41                                      ; preds = %36
  call void @abort() #4
  unreachable

; <label>:42                                      ; preds = %36
  br label %12

; <label>:43                                      ; preds = %12
  ret void
}

declare i64 @strlen(i8*) #2

; Function Attrs: nounwind uwtable
define void @f0(i8* %format, ...) #0 {
  %1 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i8* %format, i8** %1, align 8
  %2 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %3 = bitcast %struct.__va_list_tag* %2 to i8*
  call void @llvm.va_start(i8* %3)
  %4 = load i8*, i8** %1, align 8
  %5 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 0, i8* %4, %struct.__va_list_tag* %5)
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %7 = bitcast %struct.__va_list_tag* %6 to i8*
  call void @llvm.va_end(i8* %7)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #3

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #3

; Function Attrs: nounwind uwtable
define void @f1(i32 %a1, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i8* %format, i8** %2, align 8
  %3 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %4 = bitcast %struct.__va_list_tag* %3 to i8*
  call void @llvm.va_start(i8* %4)
  %5 = load i8*, i8** %2, align 8
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 1, i8* %5, %struct.__va_list_tag* %6)
  %7 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %8 = bitcast %struct.__va_list_tag* %7 to i8*
  call void @llvm.va_end(i8* %8)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f2(i32 %a1, i32 %a2, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i8* %format, i8** %3, align 8
  %4 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %5 = bitcast %struct.__va_list_tag* %4 to i8*
  call void @llvm.va_start(i8* %5)
  %6 = load i8*, i8** %3, align 8
  %7 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 2, i8* %6, %struct.__va_list_tag* %7)
  %8 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %9 = bitcast %struct.__va_list_tag* %8 to i8*
  call void @llvm.va_end(i8* %9)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f3(i32 %a1, i32 %a2, i32 %a3, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i8* %format, i8** %4, align 8
  %5 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %6 = bitcast %struct.__va_list_tag* %5 to i8*
  call void @llvm.va_start(i8* %6)
  %7 = load i8*, i8** %4, align 8
  %8 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 3, i8* %7, %struct.__va_list_tag* %8)
  %9 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %10 = bitcast %struct.__va_list_tag* %9 to i8*
  call void @llvm.va_end(i8* %10)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f4(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i8* %format, i8** %5, align 8
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %7 = bitcast %struct.__va_list_tag* %6 to i8*
  call void @llvm.va_start(i8* %7)
  %8 = load i8*, i8** %5, align 8
  %9 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 4, i8* %8, %struct.__va_list_tag* %9)
  %10 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %11 = bitcast %struct.__va_list_tag* %10 to i8*
  call void @llvm.va_end(i8* %11)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f5(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i8* %format, i8** %6, align 8
  %7 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %8 = bitcast %struct.__va_list_tag* %7 to i8*
  call void @llvm.va_start(i8* %8)
  %9 = load i8*, i8** %6, align 8
  %10 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 5, i8* %9, %struct.__va_list_tag* %10)
  %11 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %12 = bitcast %struct.__va_list_tag* %11 to i8*
  call void @llvm.va_end(i8* %12)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f6(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i32 %a6, i32* %6, align 4
  store i8* %format, i8** %7, align 8
  %8 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %9 = bitcast %struct.__va_list_tag* %8 to i8*
  call void @llvm.va_start(i8* %9)
  %10 = load i8*, i8** %7, align 8
  %11 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 6, i8* %10, %struct.__va_list_tag* %11)
  %12 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %13 = bitcast %struct.__va_list_tag* %12 to i8*
  call void @llvm.va_end(i8* %13)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f7(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i32 %a6, i32* %6, align 4
  store i32 %a7, i32* %7, align 4
  store i8* %format, i8** %8, align 8
  %9 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %10 = bitcast %struct.__va_list_tag* %9 to i8*
  call void @llvm.va_start(i8* %10)
  %11 = load i8*, i8** %8, align 8
  %12 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 7, i8* %11, %struct.__va_list_tag* %12)
  %13 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %14 = bitcast %struct.__va_list_tag* %13 to i8*
  call void @llvm.va_end(i8* %14)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f8(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i32 %a8, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i32 %a6, i32* %6, align 4
  store i32 %a7, i32* %7, align 4
  store i32 %a8, i32* %8, align 4
  store i8* %format, i8** %9, align 8
  %10 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %11 = bitcast %struct.__va_list_tag* %10 to i8*
  call void @llvm.va_start(i8* %11)
  %12 = load i8*, i8** %9, align 8
  %13 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 8, i8* %12, %struct.__va_list_tag* %13)
  %14 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %15 = bitcast %struct.__va_list_tag* %14 to i8*
  call void @llvm.va_end(i8* %15)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f9(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i32 %a8, i32 %a9, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i32 %a6, i32* %6, align 4
  store i32 %a7, i32* %7, align 4
  store i32 %a8, i32* %8, align 4
  store i32 %a9, i32* %9, align 4
  store i8* %format, i8** %10, align 8
  %11 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %12 = bitcast %struct.__va_list_tag* %11 to i8*
  call void @llvm.va_start(i8* %12)
  %13 = load i8*, i8** %10, align 8
  %14 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 9, i8* %13, %struct.__va_list_tag* %14)
  %15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %16 = bitcast %struct.__va_list_tag* %15 to i8*
  call void @llvm.va_end(i8* %16)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f10(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i32 %a8, i32 %a9, i32 %a10, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i32 %a6, i32* %6, align 4
  store i32 %a7, i32* %7, align 4
  store i32 %a8, i32* %8, align 4
  store i32 %a9, i32* %9, align 4
  store i32 %a10, i32* %10, align 4
  store i8* %format, i8** %11, align 8
  %12 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %13 = bitcast %struct.__va_list_tag* %12 to i8*
  call void @llvm.va_start(i8* %13)
  %14 = load i8*, i8** %11, align 8
  %15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 10, i8* %14, %struct.__va_list_tag* %15)
  %16 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %17 = bitcast %struct.__va_list_tag* %16 to i8*
  call void @llvm.va_end(i8* %17)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f11(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i32 %a8, i32 %a9, i32 %a10, i32 %a11, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i32 %a6, i32* %6, align 4
  store i32 %a7, i32* %7, align 4
  store i32 %a8, i32* %8, align 4
  store i32 %a9, i32* %9, align 4
  store i32 %a10, i32* %10, align 4
  store i32 %a11, i32* %11, align 4
  store i8* %format, i8** %12, align 8
  %13 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %14 = bitcast %struct.__va_list_tag* %13 to i8*
  call void @llvm.va_start(i8* %14)
  %15 = load i8*, i8** %12, align 8
  %16 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 11, i8* %15, %struct.__va_list_tag* %16)
  %17 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %18 = bitcast %struct.__va_list_tag* %17 to i8*
  call void @llvm.va_end(i8* %18)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f12(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i32 %a8, i32 %a9, i32 %a10, i32 %a11, i32 %a12, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i32 %a6, i32* %6, align 4
  store i32 %a7, i32* %7, align 4
  store i32 %a8, i32* %8, align 4
  store i32 %a9, i32* %9, align 4
  store i32 %a10, i32* %10, align 4
  store i32 %a11, i32* %11, align 4
  store i32 %a12, i32* %12, align 4
  store i8* %format, i8** %13, align 8
  %14 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %15 = bitcast %struct.__va_list_tag* %14 to i8*
  call void @llvm.va_start(i8* %15)
  %16 = load i8*, i8** %13, align 8
  %17 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 12, i8* %16, %struct.__va_list_tag* %17)
  %18 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %19 = bitcast %struct.__va_list_tag* %18 to i8*
  call void @llvm.va_end(i8* %19)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f13(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i32 %a8, i32 %a9, i32 %a10, i32 %a11, i32 %a12, i32 %a13, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i32 %a6, i32* %6, align 4
  store i32 %a7, i32* %7, align 4
  store i32 %a8, i32* %8, align 4
  store i32 %a9, i32* %9, align 4
  store i32 %a10, i32* %10, align 4
  store i32 %a11, i32* %11, align 4
  store i32 %a12, i32* %12, align 4
  store i32 %a13, i32* %13, align 4
  store i8* %format, i8** %14, align 8
  %15 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %16 = bitcast %struct.__va_list_tag* %15 to i8*
  call void @llvm.va_start(i8* %16)
  %17 = load i8*, i8** %14, align 8
  %18 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 13, i8* %17, %struct.__va_list_tag* %18)
  %19 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %20 = bitcast %struct.__va_list_tag* %19 to i8*
  call void @llvm.va_end(i8* %20)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f14(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i32 %a8, i32 %a9, i32 %a10, i32 %a11, i32 %a12, i32 %a13, i32 %a14, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i32 %a6, i32* %6, align 4
  store i32 %a7, i32* %7, align 4
  store i32 %a8, i32* %8, align 4
  store i32 %a9, i32* %9, align 4
  store i32 %a10, i32* %10, align 4
  store i32 %a11, i32* %11, align 4
  store i32 %a12, i32* %12, align 4
  store i32 %a13, i32* %13, align 4
  store i32 %a14, i32* %14, align 4
  store i8* %format, i8** %15, align 8
  %16 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %17 = bitcast %struct.__va_list_tag* %16 to i8*
  call void @llvm.va_start(i8* %17)
  %18 = load i8*, i8** %15, align 8
  %19 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 14, i8* %18, %struct.__va_list_tag* %19)
  %20 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %21 = bitcast %struct.__va_list_tag* %20 to i8*
  call void @llvm.va_end(i8* %21)
  ret void
}

; Function Attrs: nounwind uwtable
define void @f15(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i32 %a8, i32 %a9, i32 %a10, i32 %a11, i32 %a12, i32 %a13, i32 %a14, i32 %a15, i8* %format, ...) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i8*, align 8
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  store i32 %a1, i32* %1, align 4
  store i32 %a2, i32* %2, align 4
  store i32 %a3, i32* %3, align 4
  store i32 %a4, i32* %4, align 4
  store i32 %a5, i32* %5, align 4
  store i32 %a6, i32* %6, align 4
  store i32 %a7, i32* %7, align 4
  store i32 %a8, i32* %8, align 4
  store i32 %a9, i32* %9, align 4
  store i32 %a10, i32* %10, align 4
  store i32 %a11, i32* %11, align 4
  store i32 %a12, i32* %12, align 4
  store i32 %a13, i32* %13, align 4
  store i32 %a14, i32* %14, align 4
  store i32 %a15, i32* %15, align 4
  store i8* %format, i8** %16, align 8
  %17 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %18 = bitcast %struct.__va_list_tag* %17 to i8*
  call void @llvm.va_start(i8* %18)
  %19 = load i8*, i8** %16, align 8
  %20 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  call void @fap(i32 15, i8* %19, %struct.__va_list_tag* %20)
  %21 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %ap, i32 0, i32 0
  %22 = bitcast %struct.__va_list_tag* %21 to i8*
  call void @llvm.va_end(i8* %22)
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %f = alloca i8*, align 8
  store i32 0, i32* %1
  store i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str, i32 0, i32 0), i8** %f, align 8
  %2 = load i8*, i8** %f, align 8
  %3 = getelementptr inbounds i8, i8* %2, i64 0
  call void (i8*, ...) @f0(i8* %3, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %4 = load i8*, i8** %f, align 8
  %5 = getelementptr inbounds i8, i8* %4, i64 1
  call void (i32, i8*, ...) @f1(i32 0, i8* %5, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %6 = load i8*, i8** %f, align 8
  %7 = getelementptr inbounds i8, i8* %6, i64 2
  call void (i32, i32, i8*, ...) @f2(i32 0, i32 1, i8* %7, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %8 = load i8*, i8** %f, align 8
  %9 = getelementptr inbounds i8, i8* %8, i64 3
  call void (i32, i32, i32, i8*, ...) @f3(i32 0, i32 1, i32 2, i8* %9, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %10 = load i8*, i8** %f, align 8
  %11 = getelementptr inbounds i8, i8* %10, i64 4
  call void (i32, i32, i32, i32, i8*, ...) @f4(i32 0, i32 1, i32 2, i32 3, i8* %11, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %12 = load i8*, i8** %f, align 8
  %13 = getelementptr inbounds i8, i8* %12, i64 5
  call void (i32, i32, i32, i32, i32, i8*, ...) @f5(i32 0, i32 1, i32 2, i32 3, i32 4, i8* %13, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %14 = load i8*, i8** %f, align 8
  %15 = getelementptr inbounds i8, i8* %14, i64 6
  call void (i32, i32, i32, i32, i32, i32, i8*, ...) @f6(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i8* %15, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %16 = load i8*, i8** %f, align 8
  %17 = getelementptr inbounds i8, i8* %16, i64 7
  call void (i32, i32, i32, i32, i32, i32, i32, i8*, ...) @f7(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i8* %17, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %18 = load i8*, i8** %f, align 8
  %19 = getelementptr inbounds i8, i8* %18, i64 8
  call void (i32, i32, i32, i32, i32, i32, i32, i32, i8*, ...) @f8(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i8* %19, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %20 = load i8*, i8** %f, align 8
  %21 = getelementptr inbounds i8, i8* %20, i64 9
  call void (i32, i32, i32, i32, i32, i32, i32, i32, i32, i8*, ...) @f9(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i8* %21, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %22 = load i8*, i8** %f, align 8
  %23 = getelementptr inbounds i8, i8* %22, i64 10
  call void (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8*, ...) @f10(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i8* %23, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15)
  %24 = load i8*, i8** %f, align 8
  %25 = getelementptr inbounds i8, i8* %24, i64 11
  call void (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8*, ...) @f11(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i8* %25, i32 11, i32 12, i32 13, i32 14, i32 15)
  %26 = load i8*, i8** %f, align 8
  %27 = getelementptr inbounds i8, i8* %26, i64 12
  call void (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8*, ...) @f12(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i8* %27, i32 12, i32 13, i32 14, i32 15)
  %28 = load i8*, i8** %f, align 8
  %29 = getelementptr inbounds i8, i8* %28, i64 13
  call void (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8*, ...) @f13(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i8* %29, i32 13, i32 14, i32 15)
  %30 = load i8*, i8** %f, align 8
  %31 = getelementptr inbounds i8, i8* %30, i64 14
  call void (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8*, ...) @f14(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i8* %31, i32 14, i32 15)
  %32 = load i8*, i8** %f, align 8
  %33 = getelementptr inbounds i8, i8* %32, i64 15
  call void (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i8*, ...) @f15(i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i8* %33, i32 15)
  call void @exit(i32 0) #4
  unreachable
                                                  ; No predecessors!
  %35 = load i32, i32* %1
  ret i32 %35
}

; Function Attrs: noreturn nounwind
declare void @exit(i32) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = !{!"Ubuntu clang version 3.7.1-svn253571-1~exp1 (branches/release_37) (based on LLVM 3.7.1)"}
