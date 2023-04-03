
local present, dap = pcall(require, "dap")

if not present then
  return
end

  -- dap.adapters.dart = {
  --   type = "executable",
  --   command = "node",
  --   args = {"<path-to-Dart-Code>/out/dist/debug.js", "flutter"}
  -- }
  -- dap.configurations.dart = {
  --   {
  --     type = "dart",
  --     request = "launch",
  --     name = "Launch flutter",
  --     dartSdkPath = os.getenv('HOME').."/flutter/bin/cache/dart-sdk/",
  --     flutterSdkPath = os.getenv('HOME').."/flutter",
  --     program = "${workspaceFolder}/lib/main.dart",
  --     cwd = "${workspaceFolder}",
  --   }
  -- }
