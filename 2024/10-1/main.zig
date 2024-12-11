const std = @import("std");
const data = @embedFile("input.txt");
var visited: [data.len]bool = undefined;
const nCols = 55 + 1;
const nRows = 55;

fn charAt(i:u64, j:u64) u8 {
    const c = data[i*nCols + j];
    return c - '0';
}

fn followTrail(i: u64, j: u64) u64 {
    const c = charAt(i,j);
    if (c == 9) {
        if (visited[i*nCols + j]) return 0;
//        visited[i*nCols + j] = true;
        return 1;
    }
    var peaks: u64 = 0;
    if ( i >= 1 and charAt(i-1, j) == c+1) {
        peaks += followTrail(i-1, j);
    }
    if ( i + 1 < nRows and charAt(i+1, j) == c+1 ) {
        peaks += followTrail(i+1, j);
    }
    if ( j >= 1 and charAt(i, j-1) == c+1) {
        peaks += followTrail(i, j-1);
    }
    if ( j + 1 < nCols - 1 and charAt(i, j+1) == c+1 ) {
        peaks += followTrail(i, j+1);
    }
    return peaks;
}

pub fn main() void {
    var i: u64 = 0;
    var checksum: u64 = 0;
    while (i < nRows) : (i += 1) {
        var j: u64 = 0;
        while (j < nCols - 1) : (j += 1) {
            if (charAt(i,j) == 0) {
                visited = std.mem.zeroes([data.len]bool);
                const peaks = followTrail(i,j);
                checksum += peaks;
            }
        }
    }
    std.debug.print("{d}\n", .{checksum});
}
