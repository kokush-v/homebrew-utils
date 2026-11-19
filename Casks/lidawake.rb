cask "lidawake" do
  version "1.1.0"
  sha256 "8458cd396ed6ad6e5351eb19bc55bc80f108f1a3a546639f3e0f35490b60117e"

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
