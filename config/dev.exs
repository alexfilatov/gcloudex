use Mix.Config

config :goth,
  json: "config/creds_test.json" |> Path.expand |> File.read!

config :remix,
  dirs: "./",
  escript: false,
  silent: false


config :logger,
  level: :debug
