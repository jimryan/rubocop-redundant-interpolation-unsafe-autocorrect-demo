## Rubocop Style/RedundantInterpolation Unsafe Autocorrection Demo

There are (at least) two scenarios where Style/RedundantInterpolation's auto-correct is unsafe. Below are demos of each.

### Interpolated string was dup'ing a frozen string
1. Run the demo.rb file:
    ```
    $ ruby demo-frozen.rb
    ```
2. Expected output is `foo bar`
3. Apply the Style/RedundantInterpolation cop's "safe" autocorrection to the demo file:
   ```
   $ rubocop -a --only Style/RedundantInterpolation demo-frozen.rb
   ``` 
4. Rubocop will report the safe auto-correction of `demo-frozen.rb` by changing `dupd_via_interpolation = "#{frozen_string}"` to `dupd_via_interpolation = frozen_string.to_s`. `dupd_via_interpolation` is now referencing the frozen string.  
5. Run the demo once more:
   ```
   $ ruby demo-frozen.rb
    ```
6. Output is now:
   ```
   Traceback (most recent call last):
   demo-frozen.rb:5:in `<main>': can't modify frozen String: "foo" (FrozenError)
   ```

This happens because `dupd_via_interpolation` now references the frozen `frozen_string` string, which cannot be mutated.

### Interpolated string is later mutated
1. Run the demo-mutation.rb file:
    ```
    $ ruby demo-mutation.rb
    ```
2. Expected output is:
   ```
   foo
   foobar
   ```
4. Apply the Style/RedundantInterpolation cop's "safe" autocorrection to the demo file:
   ```
   $ rubocop -a --only Style/RedundantInterpolation demo-mutation.rb
   ``` 
5. Rubocop will report the safe auto-correction of `demo-mutation.rb` by changing `foobar = "#{foo}"` to `foobar = foo.to_s`. `foobar` is now referencing the exact same object as `foo`.
6. Run the demo once more:
   ```
   $ ruby demo-mutation.rb
    ```
7. Output is now:
   ```
   foobar
   foobar
   ```

This happens because `foobar` now references `foo` and so when `foobar` is mutated to add "bar", so is `foo`.
