## Rubocop Style/RedundantInterpolation Unsafe Autocorrection Demo

1. Run the demo.rb file:
    ```
    $ ruby demo.rb
    ```
2. Expected output is `foo bar`
3. Apply the Style/RedundantInterpolation cop's "safe" autocorrection to the demo file:
   ```
   $ rubocop -a --only Style/RedundantInterpolation demo.rb
   ``` 
4. Rubocop will report the safe auto-correction of `demo.rb` by changing `dupd_via_interpolation = "#{frozen_string}"` to `dupd_via_interpolation = frozen_string.to_s`
5. Run the demo once more:
   ```
   $ ruby demo.rb
    ```
6. Output is now:
   ```
   Traceback (most recent call last):
   demo.rb:5:in `<main>': can't modify frozen String: "foo" (FrozenError)
   ```
