defmodule NervesSystemX8664UEFI.MixProject do
  use Mix.Project

  @app :nerves_system_x86_64_uefi
  @version Path.join(__DIR__, "VERSION")
           |> File.read!()
           |> String.trim()

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.6",
      compilers: Mix.compilers() ++ [:nerves_package],
      nerves_package: nerves_package(),
      description: description(),
      package: package(),
      deps: deps(),
      aliases: [loadconfig: [&bootstrap/1]],
      docs: [extras: ["README.md"], main: "readme"]
    ]
  end

  def application do
    []
  end

  defp bootstrap(args) do
    System.put_env("MIX_TARGET", "x86_64_uefi")
    Application.start(:nerves_bootstrap)
    Mix.Task.run("loadconfig", args)
  end

  defp nerves_package do
    [
      type: :system,
      artifact_sites: [
        {:github_releases, "kbredemeier/#{@app}"}
      ],
      platform: Nerves.System.BR,
      platform_config: [
        defconfig: "nerves_defconfig"
      ],
      checksum: package_files()
    ]
  end

  defp deps do
    [
      {:nerves, "~> 1.3", runtime: false},
      {:nerves_system_br, "1.5.4", runtime: false},
      {:nerves_toolchain_x86_64_unknown_linux_musl, "1.1.0", runtime: false},
      {:nerves_system_linter, "~> 0.3.0", runtime: false},
      {:ex_doc, "~> 0.18", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    """
    Nerves System - x86_64_uefi
    """
  end

  defp package do
    [
      maintainers: ["Kristopher Bredemeier"],
      files: package_files(),
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/kbredemeier/#{@app}"}
    ]
  end

  defp package_files do
    [
      "fwup_include",
      "lib",
      "priv",
      "rootfs_overlay",
      "CHANGELOG.md",
      "fwup-revert.conf",
      "fwup.conf",
      "grub.cfg",
      "LICENSE",
      "linux-4.18.defconfig",
      "mix.exs",
      "nerves_defconfig",
      "post-build.sh",
      "post-createfs.sh",
      "README.md",
      "VERSION"
    ]
  end
end
