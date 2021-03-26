import Config

if config_env() == :prod do
  config :codewar, Codewar.Repo,
    ssl: true,
    url: System.fetch_env!("DATABASE_URL"),
    pool_size: String.to_integer(System.get_env("DATABASE_POOL_SIZE") || "10")

  config :codewar, CodewarWeb.Endpoint,
    http: [
      port: String.to_integer(System.get_env("PORT") || "4000")
    ],
    url: [
      host: System.fetch_env!("HOST"),
      port: String.to_integer(System.fetch_env!("PORT"))
    ],
    secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
    server: true
end
