const std = @import("std");
const data = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{.safety = false}){};
const alloc = gpa.allocator();

const Stone = struct {
    value: u64,
    prev: ?*Stone,
    next: ?*Stone,

    fn update(self: *Stone) !void {
        const n_digits = if (self.value != 0) std.math.log10_int(self.value) + 1 else 1;
        if (self.value == 0) {
            self.value = 1;
        } else if (n_digits % 2 == 0) {
            const coeff = std.math.pow(u64, 10, n_digits / 2);     
            const first_digits = self.value / coeff ;
            const last_digits = self.value - first_digits * coeff;
            const split = try alloc.create(Stone);
            split.* = Stone{.value = last_digits, .prev = self, .next = self.next};
            if (split.next) |n| {
                n.prev = split;
            }
            self.value = first_digits;
            self.next = split;

            
        } else {
            self.value *= 2024;
        }
    }
};

fn updateStones(stone: ?*Stone) !void {
    var s = stone orelse return;
    try s.update();
    while(s.prev) |prev| {
        try prev.update();
        s = prev;
    }
}

fn countStones(stone: ?*Stone) u64 {
    var s = stone orelse return 0;
    var sum: u64 = 0;
    while (s.prev) |prev| {
        sum += 1;
        s = prev;
    }
    return sum;
}

pub fn main() !void {
    var stones = std.mem.splitScalar(u8, data, ' ');
    var prev_stone: ?*Stone = null;
    var stone: *Stone = undefined;
    while (stones.next()) |stone_str| {
        const stone_value = try std.fmt.parseInt(u64, std.mem.trim(u8, stone_str, "\n"), 10);
        stone = try alloc.create(Stone);
        stone.* = Stone{.value = stone_value, .prev = prev_stone, .next = null};
        if (prev_stone) |p| {
            p.next = stone;
        }
        prev_stone = stone;
    }
    var r_head = stone;
    const blinks = 75;
  
    for (0..blinks) |_| {
        stone = r_head;
        try updateStones(stone);
        while (r_head.next) |next| {
            r_head = next;
        }
        //std.debug.print("\n", .{});
    }

    const n_stones = countStones(r_head);
    std.debug.print("{d}\n", .{n_stones});
}
