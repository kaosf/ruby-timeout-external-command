# Ruby popen3 and timeout behavior experiment

## Versions

- Ruby: 3.3.6
- Bash: 5.2.37
- timeout: 9.5 (from GNU coreutils)

## Explanation

`extern.sh` is an example of some heavy command.
It receives an argument e.g. `0` `1` `2` `3` and if it's > 2 (means it's == 3 in this experiment),
the command runs forever (with `while :; do sleep 1; done`).

Run `./extern.sh` with 4 patterns argument

```sh
./extern.sh 0
./extern.sh 1
./extern.sh 2
./extern.sh 3 # doesn't finish
```

from Ruby script.

I want the Ruby script to finish within finite time.

Ruby scripts are 3 different patterns:

- `run1.rb`: Use `system` and Ruby standard `Timeout`
- `run2.rb`: Use `Open3.popen3` and Ruby standard `Timeout`
- `run3.rb`: Use `Open3.popen3` but run the command with `timeout` command

## Results

```sh
ruby run1.rb
```

```
"Loop 0"
Finish this command (0)
true
"Loop 0 finished"
"Loop 1"
Finish this command (1)
true
"Loop 1 finished"
"Loop 2"
Finish this command (2)
true
"Loop 2 finished"
"Loop 3"
"Timeout!"
#<Timeout::Error: execution expired>
```

```sh
ruby run2.rb
```

```
"Loop 0"
"Finish this command (0)"
"Loop 0 finished"
"Loop 1"
"Finish this command (1)"
"Loop 1 finished"
"Loop 2"
"Finish this command (2)"
"Loop 2 finished"
"Loop 3"

...
Infinite loop

Press Ctrl+C to kill it.
```

```sh
ruby run3.rb
```

```
"Loop 0"
"Finish this command (0)"
"Loop 0 finished"
"Loop 1"
"Finish this command (1)"
"Loop 1 finished"
"Loop 2"
"Finish this command (2)"
"Loop 2 finished"
"Loop 3"
"Timeout!"
```

## Why run2 fails?

`popen3` waits the command finishes in its `ensure` block.

`Timeout.timeout` doesn't raise an error.

Use `timeout` command to avoid it. **I think** it's the most simple.

## References

- https://yukithm.blogspot.com/2014/03/kill.html
- https://yukithm.blogspot.com/2014/03/capture3timeout.html
- https://redmine.ruby-lang.org/issues/4681
- https://docs.ruby-lang.org/ja/latest/method/Open3/m/popen3.html
- https://zenn.dev/tkebt/articles/42284661377a27
- https://atmarkit.itmedia.co.jp/ait/articles/1906/27/news008.html
- https://www.man7.org/linux/man-pages/man1/timeout.1.html

## License

[![Public Domain](http://i.creativecommons.org/p/mark/1.0/88x31.png)](http://creativecommons.org/publicdomain/mark/1.0/ "license")

This work is free of known copyright restrictions.
