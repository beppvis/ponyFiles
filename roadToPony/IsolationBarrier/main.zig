const Node = struct {
    data: ?[]u8,
    next: *Node,
};

const CircularBuffer = struct {
    root: *Node,
    len: u8,
    curr_pos: u8 = 0,
    pub fn init(len: u8, gpa: std.mem.Allocator) !CircularBuffer {
        if (len <= 0) return .{
            .len = 0,
            .root = undefined,
        };
        var curr_node = try gpa.create(Node);
        curr_node.data = null;
        const root_node = curr_node;
        var i: u8 = 1;
        while (i < len) : (i += 1) {
            curr_node.next = try gpa.create(Node);
            curr_node = curr_node.next;
            curr_node.data = null;
        }
        curr_node.next = root_node;
        return .{
            .len = len,
            .root = root_node,
        };
    }
    pub fn send_ownership(self: *CircularBuffer, data: *[]u8, gpa: std.mem.Allocator) !void {
        var i: u8 = 0;
        var curr_node = self.root;
        while (i < self.curr_pos) : (i += 1) {
            curr_node = curr_node.next;
        }
        if (curr_node.data) |existing_data| {
            gpa.free(existing_data);
        }
        curr_node.data = data.*;
        data.* = &[_]u8{};
        self.curr_pos += 1;
        self.curr_pos = self.curr_pos % self.len;
    }
    pub fn deinit(self: *CircularBuffer, gpa: std.mem.Allocator) void {
        var i: u8 = 0;
        var curr_node = self.root;
        var prev_node: *Node = undefined;
        while (i < self.len) : (i += 1) {
            prev_node = curr_node;
            curr_node = curr_node.next;
            if (curr_node.data) |data| {
                gpa.free(data);
            }
            gpa.destroy(prev_node);
        }
    }
};

const std = @import("std");
pub fn main(init: std.process.Init) !void {
    std.debug.print("", .{});
    const gpa = init.gpa;
    var my_c_buff: CircularBuffer = try .init(2, gpa);
    defer my_c_buff.deinit(gpa);
    var data1 = try gpa.dupe(u8, "Hello World 1");
    var data2 = try gpa.dupe(u8, "Hello World 2");
    var data3 = try gpa.dupe(u8, "Hello World 3");
    try my_c_buff.send_ownership(&data1, gpa);
    try my_c_buff.send_ownership(&data2, gpa);
    try my_c_buff.send_ownership(&data3, gpa);
}
