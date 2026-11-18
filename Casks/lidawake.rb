cask "lidawake" do
  version "1.0.1"
  sha256 "0d699a6f30449d5d913d8c5dfc3779d8415a867b52cf468341ae1106b6d2511c"

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
