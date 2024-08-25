Normal js_binary:

`bazel run //src:bin`

js_binary when modifications need to be made to the output of `ts_proto_library`:

`bazel run //src:rewritten_bin`
