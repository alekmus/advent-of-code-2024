const std = @import("std");

const data = @embedFile("input.txt");

pub fn main() void {
    var checksum: u64 = 0;
    const idxCount: u64 = (data.len - 2) / 2;
    var i: u64 = data.len-2;
    var visited = std.mem.zeroes([(data.len-1)]bool);
    var idx = idxCount;
    var pos:u64 = 0;
    while (i > 0) : (i -= 2) {
        std.debug.print("{d}\n", .{idx});
        const bits = data[i] - '0';

        var j: u64 = 1;
        while (j < data.len-1) : (j += 2) {
            if ( i < j) continue;
            if (!visited[j] and (data[j]-'0' >= bits)) {
                visited[j] = true;
                for (0..bits) |_| {
                    checksum += pos * idx;
                    pos += 1;
                }
            }
        }
        idx -= 1;
    }

    i = 0;
    while (i < data.len - 1) : (i += 2) {
        const c = data[i] - '0';        
        for (0..c) |_| {
            checksum += pos * data[i] - '0';
            pos += 1;
        }
    } 
    std.debug.print("\n{d}\n", .{checksum});
}
