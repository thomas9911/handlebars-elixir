defmodule HandlebarsRs.Native do
  use Rustler, otp_app: :handlebars_rs, crate: "handlebars_rs"

  # When your NIF is loaded, it will override this function.
  def render(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
end
