defmodule HandlebarsRsTest do
  use ExUnit.Case
  doctest HandlebarsRs

  test "zappa_way" do
    template = """
    <ul class="people_list">
    {{#each people}}
      <li>{{this}}</li>
    {{/each}}
    </ul>
    """

    input = %{
      people: [
        "Yehuda Katz",
        "Alan Johnson",
        "Charles Jolley"
      ]
    }

    assert "<ul class=\"people_list\">\n  \n  \n  \n  \n    \n    \n      \n      \n  <li>Yehuda Katz</li>\n\n    \n  \n    \n    \n      \n      \n  <li>Alan Johnson</li>\n\n    \n  \n    \n    \n      \n      \n  <li>Charles Jolley</li>\n\n    \n  \n  \n\n</ul>\n" ==
             HandlebarsRs.zappa_way(template, input)
  end

  test "rust_way" do
    template = """
    <ul class="people_list">
    {{#each people}}
      <li>{{this}}</li>
    {{/each}}
    </ul>
    """

    input = %{
      people: [
        "Yehuda Katz",
        "Alan Johnson",
        "Charles Jolley"
      ]
    }

    assert "<ul class=\"people_list\">\n  <li>Yehuda Katz</li>\n  <li>Alan Johnson</li>\n  <li>Charles Jolley</li>\n</ul>\n" ==
             HandlebarsRs.rust_way(template, input)
  end
end
