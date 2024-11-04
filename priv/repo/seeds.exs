# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Painsnakes.Repo.insert!(%Painsnakes.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Painsnakes.Repo
alias Painsnakes.Accounts
alias Painsnakes.Painpoints.Painsnake
alias Painsnakes.Painpoints.Painpoint

# Fetch the team with the name "rnd"
team = Repo.get_by!(Accounts.Team, team_name: "rnd")

# Create two Painsnakes for the team
painsnake1 = %Painsnake{category_name: "Python", team_id: team.id}
painsnake2 = %Painsnake{category_name: "Cobra", team_id: team.id}

# Insert the Painsnakes into the database
painsnake1 = Repo.insert!(painsnake1)
painsnake2 = Repo.insert!(painsnake2)

# Create Painpoints for each Painsnake
painpoints1 = [
  %Painpoint{description: "Lack of documentation", painsnake_id: painsnake1.id},
  %Painpoint{description: "Complex error handling", painsnake_id: painsnake1.id}
]

painpoints2 = [
  %Painpoint{description: "High memory usage", painsnake_id: painsnake2.id},
  %Painpoint{description: "Slow startup time", painsnake_id: painsnake2.id}
]

# Insert the Painpoints into the database
Enum.each(painpoints1, &Repo.insert!/1)
Enum.each(painpoints2, &Repo.insert!/1)
