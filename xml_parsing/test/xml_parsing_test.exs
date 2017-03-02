defmodule XmlParsingTest do
  use ExUnit.Case
  doctest XmlParsing

  import SweetXml

  def sample_xml do
    """
    <html>
      <head>
        <title>XML Parsing</title>
      </head>
      <body>
        <p>Neato</p>
        <ul>
          <li>First</li>
          <li>Second</li>
        </ul>
      </body>
    </html>
    """
  end

  test "parsing the title out" do
    title_xml = sample_xml |> xpath(~x"//html/head/title/text()"l)
    [ title_element ] = title_xml
    assert title_element == 'XML Parsing'
  end

  test "parsing the p tag" do
    p_xml = sample_xml |> xpath(~x"//html/body/p/text()"l)
    [ p_text ] = p_xml
    assert p_text == 'Neato'
  end

  test "parsing the li tags and mapping them" do
    li_elements = sample_xml |> xpath(~x"//html/body/ul/li/text()"l)
    assert li_elements == ['First', 'Second']
  end
end
