const std = @import("std");

pub fn percentIf(num: f64) []const u8 {
    if (num == 0)
        return "0000000000";
    if (num > 0.0 and num <= 0.1)
        return "X000000000";
    if (num > 0.1 and num <= 0.2)
        return "XX00000000";
    if (num > 0.2 and num <= 0.3)
        return "XXX0000000";
    if (num > 0.3 and num <= 0.4)
        return "XXXX000000";
    if (num > 0.4 and num <= 0.5)
        return "XXXXX00000";
    if (num > 0.5 and num <= 0.6)
        return "XXXXXX0000";
    if (num > 0.6 and num <= 0.7)
        return "XXXXXXX000";
    if (num > 0.7 and num <= 0.8)
        return "XXXXXXXX00";
    if (num > 0.8 and num <= 0.9)
        return "XXXXXXXXX0";
    return "XXXXXXXXX";
}
const percentConst = [_][]const u8{
    "0000000000",
    "X000000000",
    "XX00000000",
    "XXX000000",
    "XXXX00000",
    "XXXXX0000",
    "XXXXXX000",
    "XXXXXXX00",
    "XXXXXXXX0",
    "XXXXXXXXX",
};

pub fn percentMathConst(num: f64) []const u8 {
    if (num >= 1.0) {
        return "XXXXXXXXX";
    }
    return percentConst[(@floatToInt(u32, num * 10))];
}

pub fn runPercentMathConst() []const u8 {
    var seed = @bitCast(u64, std.time.microTimestamp());
    var prng = std.rand.DefaultPrng.init(seed);
    const rand = prng.random();
    const count = 10_000_000;
    var i: usize = 0;
    var myString: []const u8 = undefined;
    while (true) {
        if (i > count) {
            break;
        }
        myString = percentMathConst(rand.float(f64));
        i += 1;
    }
    return myString;
}

pub fn runPercentIf() []const u8 {
    var seed = @bitCast(u64, std.time.microTimestamp());
    var prng = std.rand.DefaultPrng.init(seed);
    const rand = prng.random();
    const count = 10_000_000;
    var i: usize = 0;
    var myString: []const u8 = undefined;
    while (true) {
        if (i > count) {
            break;
        }
        myString = percentIf(rand.float(f64));
        i += 1;
    }
    return myString;
}
pub fn main() !void {
    var startTime = std.time.nanoTimestamp();
    var data = runPercentMathConst();
    var duration = std.time.nanoTimestamp() - startTime;
    std.debug.print("Time: {d}ns\n", .{duration});
    std.debug.print("string: {s}\n", .{data});

    startTime = std.time.nanoTimestamp();
    data = runPercentIf();
    duration = std.time.nanoTimestamp() - startTime;
    std.debug.print("Time: {d}ns\n", .{duration});
    std.debug.print("string: {s}\n", .{data});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
