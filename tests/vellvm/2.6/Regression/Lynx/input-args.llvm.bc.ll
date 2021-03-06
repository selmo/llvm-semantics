; ModuleID = 'input-args.llvm.bc'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-pc-linux-gnu"

@.str = private constant [9 x i8] c"argc=%i\0A\00", align 1 ; <[9 x i8]*> [#uses=1]
@.str1 = private constant [13 x i8] c"argv[%i]=%s\0A\00", align 1 ; <[13 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %0 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([9 x i8]* @.str, i32 0, i32 0), i32 %argc) nounwind ; <i32> [#uses=0]
  %1 = icmp sgt i32 %argc, 0                      ; <i1> [#uses=1]
  br i1 %1, label %bb, label %bb2

bb:                                               ; preds = %bb, %entry
  %2 = phi i32 [ %5, %bb ], [ 0, %entry ]         ; <i32> [#uses=3]
  %scevgep = getelementptr i8** %argv, i32 %2     ; <i8**> [#uses=1]
  %3 = load i8** %scevgep, align 4                ; <i8*> [#uses=1]
  %4 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([13 x i8]* @.str1, i32 0, i32 0), i32 %2, i8* %3) nounwind ; <i32> [#uses=0]
  %5 = add nsw i32 %2, 1                          ; <i32> [#uses=2]
  %exitcond = icmp eq i32 %5, %argc               ; <i1> [#uses=1]
  br i1 %exitcond, label %bb2, label %bb

bb2:                                              ; preds = %bb, %entry
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind
