const std = @import("std");
const content = @embedFile("input.txt");

const Cube = struct {
    red: usize,
    blue: usize,
    green: usize,
};

pub fn main() !void {
    std.debug.print("{d}\n", .{try part1(content)});

    std.debug.print("{d}\n", .{try part2(content)});
}

fn part1(input: []const u8) !usize {
    var result: usize = 0;
    const dices = Cube{ .red = 12, .blue = 14, .green = 13 };
    var lines = std.mem.splitSequence(u8, input, "\n");

    outer: while (lines.next()) |line| {
        if (line.len == 0) {
            continue;
        }
        var line_iter = std.mem.splitSequence(u8, line, ": ");

        var game = line_iter.next().?;
        var game_input = line_iter.next().?;
        var game_id = try std.fmt.parseInt(usize, game[5..], 10);

        var steps = std.mem.tokenizeSequence(u8, game_input, "; ");

        while (steps.next()) |step| {
            var res = Cube{ .red = 0, .blue = 0, .green = 0 };
            var output = std.mem.tokenize(u8, step, ", ");

            while (output.next()) |o| {
                const num = try std.fmt.parseInt(usize, o, 10);
                const color = output.next().?;

                if (std.mem.eql(u8, color, "red")) {
                    res.red = num;
                } else if (std.mem.eql(u8, color, "green")) {
                    res.green = num;
                } else if (std.mem.eql(u8, color, "blue")) {
                    res.blue = num;
                }
            }

            if (!(res.red <= dices.red and res.blue <= dices.blue and res.green <= dices.green)) {
                continue :outer;
            }
        }

        result += game_id;
    }

    return result;
}

fn part2(input: []const u8) !usize {
    var result: usize = 0;
    const dices = Cube{ .red = 12, .blue = 14, .green = 13 };
    _ = dices;
    var lines = std.mem.splitSequence(u8, input, "\n");

    while (lines.next()) |line| {
        if (line.len == 0) {
            continue;
        }
        var line_iter = std.mem.splitSequence(u8, line, ": ");

        var game = line_iter.next().?;
        var game_input = line_iter.next().?;
        var game_id = try std.fmt.parseInt(usize, game[5..], 10);
        _ = game_id;

        var steps = std.mem.tokenizeSequence(u8, game_input, "; ");

        var res = Cube{ .red = 0, .blue = 0, .green = 0 };

        while (steps.next()) |step| {
            var output = std.mem.tokenize(u8, step, ", ");

            while (output.next()) |o| {
                const num = try std.fmt.parseInt(usize, o, 10);
                const color = output.next().?;

                if (std.mem.eql(u8, color, "red")) {
                    res.red = if (num > res.red) num else res.red;
                } else if (std.mem.eql(u8, color, "green")) {
                    res.green = if (num > res.green) num else res.green;
                } else if (std.mem.eql(u8, color, "blue")) {
                    res.blue = if (num > res.blue) num else res.blue;
                }
            }
        }

        result += res.red * res.green * res.blue;
    }

    return result;
}
