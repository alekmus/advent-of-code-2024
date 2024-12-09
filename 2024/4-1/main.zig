const std = @import("std");
const data = @embedFile("input.txt");

fn charAtData(i: i64, j: i64) u8 {
    if (i >= 0 and i<140 and j >= 0 and j < 141) {
        return data[@as(u64,@intCast(i))*141+@as(u64,@intCast(j))]; 
    }
    return '.';
}

fn checkPos(i: i64, j: i64) u64 {
    var sum: u64 = 0;
    sum += @intFromBool(charAtData(i+1, j) == 'M' and charAtData(i+2, j) == 'A' and charAtData(i+3, j) == 'S');
    sum += @intFromBool(charAtData(i-1, j) == 'M' and charAtData(i-2, j) == 'A' and charAtData(i-3, j) == 'S');
    
    sum += @intFromBool(charAtData(i, j+1) == 'M' and charAtData(i, j+2) == 'A' and charAtData(i, j+3) == 'S');
    sum += @intFromBool(charAtData(i, j-1) == 'M' and charAtData(i, j-2) == 'A' and charAtData(i, j-3) == 'S');
    
    sum += @intFromBool(charAtData(i+1, j+1) == 'M' and charAtData(i+2, j+2) == 'A' and charAtData(i+3, j+3) == 'S');
    sum += @intFromBool(charAtData(i-1, j-1) == 'M' and charAtData(i-2, j-2) == 'A' and charAtData(i-3, j-3) == 'S');
    
    sum += @intFromBool(charAtData(i-1, j+1) == 'M' and charAtData(i-2, j+2) == 'A' and charAtData(i-3, j+3) == 'S');
    sum += @intFromBool(charAtData(i+1, j-1) == 'M' and charAtData(i+2, j-2) == 'A' and charAtData(i+3, j-3) == 'S');
    return sum;
}

pub fn main() void {
    var sum: u64 = 0;
    for (0..140) |i| {
        for (0..141) |j| {
            const c = data[i*141+j];
            if (c == 'X') {
                sum += checkPos(@as(i64, @intCast(i)), @as(i64, @intCast(j)));
            }
        }
    }
    std.debug.print("\n{d}\n", .{sum});
}
