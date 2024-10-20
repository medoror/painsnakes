# Next up
  * Ship it script?
    * Should this be a bash script or a mix task?
  * Implement auth
    * mix phx.gen.auth Accounts Team teams --live
    * team should be registering using the name and password to log in
  * Implement business logic
    - mix phx.gen.context Painpoints Painsnake painsnakes category_name:string team_id:references:teams
    - mix phx.gen.context Painpoints Painpoint painpoints description:text creation_date:utc_datetime painsnake_id:references:painsnakes
    - mix ecto.migrate
  * Implement UI


# Random Thoughts
  * Look and feel similar to rnd pears?
  * Change the hostname
  * Create releases
  * LLM
    *  Open source vs OpenAI
  * Data modeling
    * painpoint 
      * description 
      * creation date
    * painsnake - use gen ai to create category
      * category name
      * list of painpoints
  * board is associated with login
  * moving pain points to different snakes and should updates painsnake category name
  * create categories and painpointss under categories
