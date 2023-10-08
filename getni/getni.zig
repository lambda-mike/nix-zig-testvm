const std = @import("std");

const c = @cImport({
    // See https://github.com/ziglang/zig/issues/515
    @cDefine("_NO_CRT_STDIO_INLINE", "1");
    @cInclude("stdio.h");
    @cInclude("stdlib.h");
    @cInclude("unistd.h");
});

// Optional: extra errors
const UnixError = error {
    GetHostnameError,
    GetDomainError,
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stderr = std.io.getStdErr().writer();

    // Initialize with space character
    var hostname = [_]u8{20} ** 1024;
    const hostcode = c.gethostname(&hostname, 1024);
    if (hostcode != 0) {
        try stderr.print("hostname error code: {d}\n", .{hostcode});
        return error.GetHostnameError;
    }
    try stdout.print("hostname: {s} (code: {d})\n", .{hostname, hostcode});

    // Initialize with space character
    var domainname = [_]u8{20} ** 1024;
    const domaincode = c.getdomainname(&domainname, 1024);
    if (domaincode != 0) {
        try stderr.print("domain error code: {d}\n", .{domaincode});
        return error.GetDomainError;
    }
    try stdout.print("domainname: {s}\n", .{domainname});
}
