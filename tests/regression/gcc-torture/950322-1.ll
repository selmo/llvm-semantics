; ModuleID = '/home/grosu/celliso2/c-semantics/tests/gcc-torture/950322-1.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

define i32 @gnu_dev_major(i64 %__dev) nounwind uwtable inlinehint {
entry:
  %__dev.addr = alloca i64, align 8
  store i64 %__dev, i64* %__dev.addr, align 8
  %tmp = load i64* %__dev.addr, align 8
  %shr = lshr i64 %tmp, 8
  %and = and i64 %shr, 4095
  %tmp1 = load i64* %__dev.addr, align 8
  %shr2 = lshr i64 %tmp1, 32
  %conv = trunc i64 %shr2 to i32
  %and3 = and i32 %conv, -4096
  %conv4 = zext i32 %and3 to i64
  %or = or i64 %and, %conv4
  %conv5 = trunc i64 %or to i32
  ret i32 %conv5
}

define i32 @gnu_dev_minor(i64 %__dev) nounwind uwtable inlinehint {
entry:
  %__dev.addr = alloca i64, align 8
  store i64 %__dev, i64* %__dev.addr, align 8
  %tmp = load i64* %__dev.addr, align 8
  %and = and i64 %tmp, 255
  %tmp1 = load i64* %__dev.addr, align 8
  %shr = lshr i64 %tmp1, 12
  %conv = trunc i64 %shr to i32
  %and2 = and i32 %conv, -256
  %conv3 = zext i32 %and2 to i64
  %or = or i64 %and, %conv3
  %conv4 = trunc i64 %or to i32
  ret i32 %conv4
}

define i64 @gnu_dev_makedev(i32 %__major, i32 %__minor) nounwind uwtable inlinehint {
entry:
  %__major.addr = alloca i32, align 4
  %__minor.addr = alloca i32, align 4
  store i32 %__major, i32* %__major.addr, align 4
  store i32 %__minor, i32* %__minor.addr, align 4
  %tmp = load i32* %__minor.addr, align 4
  %and = and i32 %tmp, 255
  %tmp1 = load i32* %__major.addr, align 4
  %and2 = and i32 %tmp1, 4095
  %shl = shl i32 %and2, 8
  %or = or i32 %and, %shl
  %conv = zext i32 %or to i64
  %tmp3 = load i32* %__minor.addr, align 4
  %and4 = and i32 %tmp3, -256
  %conv5 = zext i32 %and4 to i64
  %shl6 = shl i64 %conv5, 12
  %or7 = or i64 %conv, %shl6
  %tmp8 = load i32* %__major.addr, align 4
  %and9 = and i32 %tmp8, -4096
  %conv10 = zext i32 %and9 to i64
  %shl11 = shl i64 %conv10, 32
  %or12 = or i64 %or7, %shl11
  ret i64 %or12
}

define i32 @f(i8* %a) nounwind uwtable {
entry:
  %a.addr = alloca i8*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  store i8* %a, i8** %a.addr, align 8
  %tmp = load i8** %a.addr, align 8
  %arrayidx = getelementptr inbounds i8* %tmp, i64 1
  %tmp1 = load i8* %arrayidx
  %conv = zext i8 %tmp1 to i32
  store i32 %conv, i32* %j, align 4
  %tmp2 = load i8** %a.addr, align 8
  %arrayidx3 = getelementptr inbounds i8* %tmp2, i64 0
  %tmp4 = load i8* %arrayidx3
  %conv5 = zext i8 %tmp4 to i32
  %tmp6 = load i32* %j, align 4
  %sub = sub nsw i32 %conv5, %tmp6
  store i32 %sub, i32* %i, align 4
  %tmp7 = load i32* %i, align 4
  %cmp = icmp slt i32 %tmp7, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 1, i32* %x, align 4
  %tmp9 = load i32* %i, align 4
  %sub10 = sub nsw i32 0, %tmp9
  store i32 %sub10, i32* %y, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  store i32 0, i32* %x, align 4
  %tmp11 = load i32* %i, align 4
  store i32 %tmp11, i32* %y, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %tmp12 = load i32* %x, align 4
  %tmp13 = load i32* %y, align 4
  %add = add nsw i32 %tmp12, %tmp13
  ret i32 %add
}

define i32 @main() nounwind uwtable {
entry:
  %retval = alloca i32, align 4
  %a = alloca [2 x i8], align 1
  store i32 0, i32* %retval
  %arrayidx = getelementptr inbounds [2 x i8]* %a, i32 0, i64 0
  store i8 8, i8* %arrayidx, align 1
  %arrayidx1 = getelementptr inbounds [2 x i8]* %a, i32 0, i64 1
  store i8 9, i8* %arrayidx1, align 1
  %arraydecay = getelementptr inbounds [2 x i8]* %a, i32 0, i32 0
  %call = call i32 @f(i8* %arraydecay)
  %cmp = icmp ne i32 %call, 2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  call void @abort() noreturn nounwind
  unreachable

if.end:                                           ; preds = %entry
  call void @exit(i32 0) noreturn nounwind
  unreachable

return:                                           ; No predecessors!
  %0 = load i32* %retval
  ret i32 %0
}

declare void @abort() noreturn nounwind

declare void @exit(i32) noreturn nounwind