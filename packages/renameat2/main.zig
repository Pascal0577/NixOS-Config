const std = @import("std");

pub fn main(init: std.process.Init.Minimal) !void {
    const args = init.args.vector;
    if (args.len != 3) {
        std.debug.print("usage: renameat2 file1 file2\n", .{});
        std.process.exit(1);
    }

    const dirfd = std.Io.Dir.cwd().handle;
    const id = std.os.linux.renameat2(dirfd, args[1], dirfd, args[2], .{ .EXCHANGE = true });
    const errno = std.posix.errno(id);
    switch (errno) {
        .ACCES, .PERM => std.debug.print("Permission denied\n", .{}),
        .BUSY => std.debug.print("One or both files are busy\n", .{}),
        .FAULT => std.debug.print("One or both files are outside your address space. How did you even get this error?\n", .{}),
        .INVAL => std.debug.print("You tried to make a directory a subdirectory if itself, silly goose\n", .{}),
        .ISDIR => std.debug.print("One of the arguments is a directory, but the other isn't\n", .{}),
        .LOOP => std.debug.print("Too many symlinks encountered when resolving paths\n", .{}),
        .MLINK => std.debug.print("Tried to exceed max number of links\n", .{}),
        .NAMETOOLONG => std.debug.print("One or both files has too long a name\n", .{}),
        .NOENT => std.debug.print("One or both paths don't exist\n", .{}),
        .NOMEM => std.debug.print("Out of memory!\n", .{}),
        .NOSPC => std.debug.print("Out of space!\n", .{}),
        .NOTDIR => std.debug.print("One of the arguments is a directory, but the other isn't\n", .{}),
        .NOTEMPTY, .EXIST => std.debug.print("Nonempty directory\n", .{}),
        .ROFS => std.debug.print("Read-only filesystem!\n", .{}),
        .XDEV => std.debug.print("`renameat2` doesn't work across mountpoints\n", .{}),
        else => {
            std.debug.print("Success!\n", .{});
            return;
        }
    }

    std.process.exit(@truncate(@intFromEnum(errno)));
}
