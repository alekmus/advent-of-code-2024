const std = @import("std");
const data = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

fn checkValidity(answer: u64, sum: u64, input: std.ArrayList(u64), i: u64)  bool {
    if (i >= input.items.len){
        return answer == sum;
    }
    const value = input.items[i];
    const nDigits: u64 = @intFromFloat(
        @floor(
            @log10(
                @as(
                    f32,
                    @floatFromInt(value)
                )
            )+1
        )
    );
    const concatValue = sum*std.math.pow(u64, 10, nDigits)+value;
    //std.debug.print("{d} - {d} - {d} - {d}\n", .{nDigits, value, sum, concatValue});
    return checkValidity(answer, sum + value, input, i+1) 
        or checkValidity(answer, sum * value, input, i+1)
        or checkValidity(answer, concatValue, input, i+1);
}

pub fn main() !void {
    var lines = std.mem.splitScalar(u8, data, '\n');
    var sum: u64 = 0;
    while(lines.next()) | line | {
        var input = std.mem.splitScalar(u8, line, ':');
        const ans: u64 =  std.fmt.parseInt(u64, input.first(), 10) catch {continue;};
        var list = std.ArrayList(u64).init(allocator);
        var nums = std.mem.splitScalar(u8, input.next().?, ' ');
        while (nums.next()) |val| {
            //std.debug.print("{c}\n", .{val});
            const intVal =  std.fmt.parseInt(u64, val, 10) catch {continue;};
            try list.append(intVal);
        } 
        if (checkValidity(ans, 0, list, 0)) {
            sum += ans;
        }
    }
    std.debug.print("{d}", .{sum});
}
