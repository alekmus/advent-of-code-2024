const std = @import("std");
const data = @embedFile("input.txt");

pub fn main() !void {
    var lines = std.mem.splitScalar(u8, data, '\n');
    std.debug.print("{d}", .{data.len});
    var ch_list: [1000]u64 = undefined;
    var sh_list: [1000]u64 = undefined;
    var i: u64 = 0;
    while (lines.next()) |line| {
        if (line.len == 0) {
            break;
        }
        var split = std.mem.splitScalar(u8, line, ' ');
        const first = split.first();
        ch_list[i] = try std.fmt.parseInt(u64, first, 10);
        sh_list[i] = try std.fmt.parseInt(u64, split.next().?, 10);
        i += 1;
    }

    std.mem.sort(u64, &ch_list, {}, comptime std.sort.asc(u64));
    std.mem.sort(u64, &sh_list, {}, comptime std.sort.asc(u64));

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var map = std.AutoHashMap(u64, u64).init(allocator);

    for (sh_list) |sh| {
        const val = map.get(sh);
        if (val == null) {
            try map.put(sh, 0);
        }
        try map.put(sh, map.get(sh).? + 1);
    }
    var similarity: u64 = 0;
    var prev: u64 = ch_list[0];

    similarity += map.get(prev) orelse 0;
    for (ch_list) |ch| {
        if (ch == prev) {
            continue;
        }

        std.debug.print("{d}\n", .{ch});
        const coeff = map.get(ch) orelse 0;
        similarity += ch * coeff;
        prev = ch;
    }
    std.debug.print("{d}\n", .{similarity});
}
