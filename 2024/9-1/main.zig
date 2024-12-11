const std = @import("std");

const data = @embedFile("input.txt");

pub fn main() void {
    var checksum: u64 = 0;
   
    var startIdx: u64 = 0;
    var endIdx: u64 = data.len - 2;
    var endAmount: u64 = data[endIdx] - '0';
    
    var pos: u64 = 0;
    
    var i: u64 = 0;
    while ( startIdx < endIdx/2 ) : (i += 1) {
        const n = data[i] - '0';

        if ( i % 2 == 0) {
            for (0..n) |_| {
  //              std.debug.print("{d} * {d} = {d}\n", .{pos, startIdx, pos*startIdx});
                checksum += pos * startIdx;
                pos += 1;
            } 
            startIdx += 1;
        } else {
            for (0..n) |_| {
//                std.debug.print("{d} * {d} = {d}\n", .{pos, endIdx/2, pos*(endIdx / 2)});
                endAmount -= 1;
                checksum += pos * (endIdx / 2);
                if (endAmount < 1) {
                    endIdx -= 2;
                    endAmount = data[endIdx] - '0';
                }
                pos += 1;
            }
        }
    }
    for (0..endAmount) |_| {
    //    std.debug.print("{d} * {d} = {d}\n", .{pos, endIdx/2, pos*(endIdx / 2)});
        checksum += pos * (endIdx / 2);
        pos += 1;
    }
    std.debug.print("\n{d}\n", .{checksum});
}
