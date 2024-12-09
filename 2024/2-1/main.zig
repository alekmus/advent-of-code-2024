const std = @import("std");
const data = @embedFile("input.txt");

pub fn main() !void {
    var lines = std.mem.splitScalar(u8, data, '\n');
    var sum: u32 = 0;
    while (lines.next()) |line| {
        if (line.len == 0) break;

        var readings = std.mem.splitScalar(u8, line, ' ');
        var prev_diff: i32 = 0;
        while (readings.next()) |reading| {
            const next = readings.peek();
            if (next == null) continue;

            const diff = try std.fmt.parseInt(i32, reading, 10) - try std.fmt.parseInt(i32, next.?, 10);
            if (@abs(diff) > 3 or @abs(diff) < 1) break;

            if (prev_diff != 0) {
                if ((diff > 0) != (prev_diff > 0)) break;
            }
            prev_diff = diff;
        } else {
            sum += 1;
        }
    }
    std.debug.print("{d}\n", .{sum});
}
