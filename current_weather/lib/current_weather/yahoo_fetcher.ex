defmodule CurrentWeather.YahooFetcher do

  import SweetXml

  def fetch(woeid) do
    body = get(woeid)
    temp = extract_temperature(body)
    temp
  end

  defp extract_temperature(body) do
    condition_xml = body |> xpath(~x"//current/temperature/@value"l)
    [ condition_element ] = condition_xml
    condition_element
  end

  defp get(woeid) do
    response = HTTPotion.get(url_for(woeid))
    response.body
  end

  defp url_for(woeid) do
    "http://samples.openweathermap.org/data/2.5/weather?q=#{woeid}&mode=xml&appid=b1b15e88fa797225412429c1c50c122a1"
  end
end
