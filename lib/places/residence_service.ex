defmodule Places.ResidenceService do
    def list_areas do
      ["Area 1", "Area 2", "Area 3"]

    #   response = HTTPoison.get "http://api.auroville.org.in/residence"
    # # The assumption here is that the above API will provide a list of residence areas as JSON data.
    #  Poison.decode!(response.body)
    # # Poison library is already available in our Phoenix project.
    # # We call the `decode!/1` function to convert the response body into an Elixir List.
  end

end
