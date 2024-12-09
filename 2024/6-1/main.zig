const std = @import("std");
var data = @embedFile("input.txt");

const nCols = 131;
const nRows = 130;
var visited = std.mem.zeroes([nCols*nRows]bool);

fn trans(c: u8) u8 {
    switch(c) {
        '>' => {return 'v';},
        '<' => {return '^';},
        '^' => {return '>';},
        'v' => {return '<';},
        else => unreachable
    }
}

fn move(c: u8) [2]i64 {
     switch(c) {
        '>' => {return .{0, 1};},
        '<' => {return .{0, -1};},
        '^' => {return .{-1,0};},
        'v' => {return .{1, 0};},
        else => unreachable
    }
}

fn charAtData(i: i64, j: i64) ?u8 {
    if (i >= 0 and i<nCols and j >= 0 and j < nCols) {
        return data[@as(u64,@intCast(i))*nCols+@as(u64,@intCast(j))]; 
    }
    return null;
}

fn start(i: u64, j: u64) void {
    var c: u8 = '^';
    var direction = move(c);
    var currI: i64=@as(i64,  @intCast(i));
    var currJ: i64= @as(i64,  @intCast(j));
    visited[i*nCols+j] = true; 
    var nextI: i64 = currI + direction[0];
    var nextJ: i64= currJ + direction[1];
    std.debug.print("{d} {d}  - {d} {d}\n", .{i, j, nextI, nextJ});
    while(charAtData(nextI, nextJ)) |nextC| {
        if (nextC == '#') {
            c = trans(c);
            direction = move(c);
        } else {
            currI = nextI;
            currJ = nextJ;
            visited[@as(u64,@intCast(currI))*nCols+@as(u64,@intCast(currJ))] = true; 
        } 
        

        nextI = currI + direction[0];
        nextJ = currJ + direction[1];

    }
}

pub fn main() void {
    outer: for (0..nRows) |i| {
        for (0..nCols) |j| {
            const c = data[i*nCols+j];
            if (c == '^') {
                start(i, j);
                break :outer;
            }
        }
    }
    var sum: u64 = 0;
    for (0..nRows) |i| {
        for (0..nCols) |j| {
            sum += @intFromBool(visited[i*nCols+j]);
            std.debug.print("{d} ", .{@intFromBool(visited[i*nCols+j])});
//            std.debug.print("{c} ", .{(data[i*size+j])});
        }
           std.debug.print("\n", .{});
  }

    std.debug.print("{d}\n", .{sum});
}
