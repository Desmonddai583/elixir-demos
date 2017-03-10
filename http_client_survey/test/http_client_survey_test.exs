defmodule HttpClientSurveyTest do
  use ExUnit.Case
  doctest HttpClientSurvey

  test "parsing the content of a page" do
    response = HTTPotion.get "http://example.com"
    assert Regex.match?(~r/illustrative examples/, response.body)
  end
end
