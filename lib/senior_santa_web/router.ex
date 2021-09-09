defmodule SeniorSantaWeb.Router do
  use SeniorSantaWeb, :router
  # , scope: "/admin", pipe_through: [:some_plug, :authenticate]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SeniorSantaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SeniorSantaWeb do
    pipe_through :browser

    live "/letters", LetterLive.Index, :render
    live "/letters/:letter_id", LetterLive.Show, :render
  end

  # Other scopes may use custom stacks.
  # scope "/api", SeniorSantaWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard",
        metrics: SeniorSantaWeb.Telemetry,
        ecto_repos: [SeniorSanta.Repo]
    end
  end

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end
end
