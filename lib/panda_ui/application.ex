defmodule PandaUi.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(PandaUi.Cache, [])
    ]

    opts = [strategy: :one_for_one, name: PandaUi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end