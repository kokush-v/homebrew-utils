cask "lidawake" do
  version "0.0.1-test"
  sha256 "754f0b4019e556128bd30373081c1ed7fa4ee62304578a798b9a6132a31113a0"

  url "https://github.com/kokush-v/lidawake/releases/download/v#{version}/LidAwake-#{version}.zip"
  name "LidAwake"
  desc "Keeps the computer running with the lid closed"
  homepage "https://github.com/kokush-v/lidawake"

  depends_on macos: :ventura

  app "LidAwake.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/LidAwake.app"]
  end

  uninstall quit:       "com.lidawake.app",
            login_item: "LidAwake",
            script:     {
              executable:   "/usr/bin/sudo",
              args:         ["-n", "/usr/bin/pmset", "-a", "disablesleep", "0"],
              must_succeed: false,
            },
            delete:     "/etc/sudoers.d/lidawake"
end
