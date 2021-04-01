# coveralls-ignore-start
defmodule CodewarWeb.Home.Spinner do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <div class="blank-state spinner">
      <div class="spinner-grow text-secondary" role="status">
        <span class="visually-hidden">Loading...</span>
      </div>
      <div class="spinner-grow text-secondary" role="status">
        <span class="visually-hidden">Loading...</span>
      </div>
      <div class="spinner-grow text-secondary" role="status">
        <span class="visually-hidden">Loading...</span>
      </div>
    </div>
    """
  end
end
