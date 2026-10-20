const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    // Zig 0.16's native ELF linker cannot handle PC64 relocations in newer glibc.
    const use_llvm: ?bool = if (target.result.os.tag == .linux and target.result.cpu.arch == .x86_64) true else null;
    const optimize = b.standardOptimizeOption(.{});

    const module = b.addModule("ShellyHttp", .{
        .root_source_file = b.path("src/http_client.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = target.result.os.tag == .linux,
    });

    const tests = b.addTest(.{ .use_llvm = use_llvm, .use_lld = use_llvm, .root_module = module });
    const test_step = b.step("test", "Run compatibility HTTP client tests");
    test_step.dependOn(&b.addRunArtifact(tests).step);
}
