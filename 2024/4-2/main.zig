const std = @import("std");
const data = @embedFile("input.txt");

fn charAtData(i: i64, j: i64) u8 {
    if (i >= 0 and i<140 and j >= 0 and j < 141) {
        return data[@as(u64,@intCast(i))*141+@as(u64,@intCast(j))]; 
    }
    return '.';
}

fn checkPos(i: i64, j: i64) bool {

    const a = charAtData(i-1, j-1) == 'M' and charAtData(i+1, j+1) == 'S' and charAtData(i-1, j+1) == 'M' and charAtData(i+1, j-1) == 'S';
    const b = charAtData(i-1, j-1) == 'S' and charAtData(i+1, j+1) == 'M' and charAtData(i-1, j+1) == 'M' and charAtData(i+1, j-1) == 'S';
    const c = charAtData(i-1, j-1) == 'M' and charAtData(i+1, j+1) == 'S' and charAtData(i-1, j+1) == 'S' and charAtData(i+1, j-1) == 'M';
    const d = charAtData(i-1, j-1) == 'S' and charAtData(i+1, j+1) == 'M' and charAtData(i-1, j+1) == 'S' and charAtData(i+1, j-1) == 'M';
    return a or b or c or d;
}

pub fn main() void {
    var sum: u64 = 0;
    for (0..140) |i| {
        for (0..141) |j| {
            const c = data[i*141+j];
            if (c == 'A') {
                if (checkPos(@as(i64, @intCast(i)), @as(i64, @intCast(j)))){
                    sum += 1;
                }
            }
        }
    }
    std.debug.print("\n{d}\n", .{sum});
}
