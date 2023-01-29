const std = @import("std");

const MAX_COUNT = 10_000_000;

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
    return "XXXXXXXXXX";
}
const percentConst = [_][]const u8{
    "0000000000",
    "X000000000",
    "XX00000000",
    "XXX0000000",
    "XXXX000000",
    "XXXXX00000",
    "XXXXXX0000",
    "XXXXXXX000",
    "XXXXXXXX00",
    "XXXXXXXXX0",
    "XXXXXXXXXX",
};

pub fn percentMathConst(num: f64) []const u8 {
    if (num >= 1.0) {
        return "XXXXXXXXXX";
    }
    return percentConst[(@floatToInt(u32, num * 10))];
}

pub fn runPercentMathConst() []const u8 {
    var seed = @bitCast(u64, std.time.microTimestamp());
    var prng = std.rand.DefaultPrng.init(seed);
    const rand = prng.random();
    var myString: []const u8 = undefined;
    var i: usize = 0;
    while (i < MAX_COUNT) : (i += 1) {
        myString = percentMathConst(rand.float(f64));
    }
    return myString;
}

pub fn runPercentIf() []const u8 {
    var seed = @bitCast(u64, std.time.microTimestamp());
    var prng = std.rand.DefaultPrng.init(seed);
    const rand = prng.random();
    var myString: []const u8 = undefined;
    var i: usize = 0;
    while (true) {
        if (i > MAX_COUNT) {
            break;
        }
        myString = percentIf(rand.float(f64));
        i += 1;
    }
    return myString;
}

fn bench(comptime func: fn () []const u8) []const u8 {
    var start = std.time.microTimestamp();
    var result = func();
    var end = std.time.microTimestamp();
    var elapsed = end - start;
    std.debug.print("Elapsed: {d}us\n", .{@intToFloat(f64, elapsed) / std.time.us_per_s});
    return result;
}

pub fn main() !void {
    std.debug.print("percentIf: {s}\n", .{bench(runPercentIf)});
    std.debug.print("mathConst: {s}\n", .{bench(runPercentMathConst)});
}
