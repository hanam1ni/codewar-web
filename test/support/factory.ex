defmodule Codewar.Factory do
  use ExMachina.Ecto, repo: Codewar.Repo

  use Codewar.Competition.ChallengeFactory
  use Codewar.Competition.SessionFactory
end
