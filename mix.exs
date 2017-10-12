defmodule NervesSystemX8664.Mixfile do
  use Mix.Project

  @version Path.join(__DIR__, "VERSION")
    |> File.read!
    |> String.trim

  def project do
    [app: :nerves_system_x86_64,
     version: @version,
     elixir: "~> 1.4",
     compilers: Mix.compilers ++ [:nerves_package],
     description: description(),
     package: package(),
     deps: deps(),
     aliases: ["deps.precompile": ["nerves.env", "deps.precompile"]]]
  end

  def application do
    []
  end

  defp deps do
    [
      {:nerves, "~> 0.7", runtime: false},
      {:nerves_system_br, "~> 0.13", runtime: false},
      {:nerves_toolchain_x86_64_unknown_linux_gnu, "~> 0.11.0", runtime: false}
    ]
  end

  defp description do
    """
    Nerves System - x86_64
    """
  end

  defp package do
   [maintainers: ["Frank Hunleth"],
     files: ["LICENSE", "mix.exs", "nerves_defconfig", "nerves.exs", "README.md",
             "VERSION", "rootfs_overlay", "linux-4.13.defconfig", "grub.cfg",
             "post-createfs.sh"],
    licenses: ["Apache 2.0"],
     links: %{"Github" => "https://github.com/fhunleth/nerves_system_x86_64"}]
  end
end
