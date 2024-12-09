const std = @import("std");
const data = @embedFile("input.txt");

pub fn main() !void {
    var lines = std.mem.splitScalar(u8, data, '\n');

    var ch_list: [data.len]u32 = undefined;
    var sh_list: [data.len]u32 = undefined;
    var i: u32 = 0;
    while (lines.next()) |line| {
        if (line.len == 0) {
            break;
        }
        var split = std.mem.splitScalar(u8, line, ' ');
        const first = split.first();
        ch_list[i] = try std.fmt.parseInt(u32, first, 10);
        sh_list[i] = try std.fmt.parseInt(u32, split.next().?, 10);
        i += 1;
    }

    std.mem.sort(u32, &ch_list, {}, comptime std.sort.asc(u32));
    std.mem.sort(u32, &sh_list, {}, comptime std.sort.asc(u32));

    var sum: u64 = 0;
    for (ch_list, sh_list) |ch, sh| {
        sum += if (sh > ch) sh - ch else ch - sh;
    }
    std.debug.print("{d}\n", .{sum});
}
