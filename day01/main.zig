const std = @import("std");
const content = @embedFile("input.txt");

const numbers = [_][]const u8{
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
};

pub fn main() !void {
    var part1: usize = 0;
    var part2: usize = 0;

    var linesIter = std.mem.tokenize(u8, content, "\n");
    while (linesIter.next()) |line| {
        var startDigit: usize = 0;
        for (0..line.len) |i| {
            if (std.ascii.isDigit(line[i])) {
                startDigit = line[i] - '0';
                break;
            }
        }

        var secDigit: usize = 0;
        for (0..line.len) |i| {
            const pos = line.len - i - 1;
            if (std.ascii.isDigit(line[pos])) {
                secDigit = line[pos] - '0';
                break;
            }
        }

        part1 += startDigit * 10 + secDigit;
    }

    var linesIter2 = std.mem.tokenize(u8, content, "\n");
    while (linesIter2.next()) |line| {
        var firstDigit: usize = 0;

        outer: for (0..line.len) |i| {
            const slc = line[i..];

            if (std.ascii.isDigit(line[i])) {
                firstDigit = line[i] - '0';
                break :outer;
            }

            for (numbers, 1..) |num, j| {
                if (std.mem.startsWith(u8, slc, num)) {
                    firstDigit = j;
                    break :outer;
                }
            }
        }

        var lastDigit: usize = 0;
        outer: for (0..line.len) |i| {
            const ch = line.len - i - 1;
            const slc = line[ch..];

            if (std.ascii.isDigit(line[ch])) {
                lastDigit = line[ch] - '0';
                break :outer;
            }

            for (numbers, 0..) |num, j| {
                if (std.mem.startsWith(u8, slc, num)) {
                    lastDigit = j + 1;
                    break :outer;
                }
            }
        }

        part2 += (firstDigit * 10) + lastDigit;
    }

    std.debug.print("Part 1 {d}, Part 2 {d}\n ", .{ part1, part2 });
}
