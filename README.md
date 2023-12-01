# Advent of Code Template

## Setup

Codespaces/Devcontainer support is included.

Otherwise, `rbenv` or equivalent with Ruby 3.2.2 will do nicely.

Dependencies are kept to a minimum:
- `minitest` handles autorun for files
- `rake`

## Running the examples

To solve for Day 1:
```bash
ruby src/day1/solution.rb
```

To demonstrate with the sample input for Day 1:
```bash
ruby src/day1/solution.rb -n test_sample
```

## Run all examples

```bash
rake test
```

## Create next day's files

```bash
rake next_day
```
