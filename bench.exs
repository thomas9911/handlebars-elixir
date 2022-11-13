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

Benchee.run(
  %{
    "zappa" => fn input -> HandlebarsRs.zappa_way(template, input) end,
    "rust" => fn input -> HandlebarsRs.rust_way(template, input) end
  },
  inputs: %{
    "Small" => input
  }
)


## MIX_ENV=prod
## $Env:MIX_ENV='prod'

# Benchmarking rust with input Small ...
# Benchmarking zappa with input Small ...

# ##### With input Small #####
# Name            ips        average  deviation         median         99th %
# rust        29.55 K       33.85 μs   ±144.02%           0 μs      102.40 μs
# zappa        1.29 K      774.47 μs    ±23.19%      716.80 μs     1433.60 μs

# Comparison:
# rust        29.55 K
# zappa        1.29 K - 22.88x slower +740.62 μs
