# httpie
httpie running in docker alpine (python3+pip3+alpine+httpie)

[![DockerHub Badge](http://dockeri.co/image/alpine/httpie)](https://hub.docker.com/r/alpine/httpie/)


### Notes

This is personal project to build httpie in alpine linux.

### Usage

```bash
$ alias http='docker run -ti --rm alpine/httpie'
```

This will create a temporary alias. In order to make it persist reboots,
you can append this exact line to your `~/.bashrc` (or similar) like this:

```bash
$ alias http >> ~/.bashrc
```

Running HTTPie is as simple as invoking it like this:

> *From [the official examples](https://github.com/jakubroztocil/httpie#examples):*

Hello World:

```bash
$ http httpie.org
```

Custom HTTP method and headers:

```bash
$ http PUT example.org X-API-Token:123 name=John
```

Submitting forms:

```bash
$ http -f POST example.org hello=World
```

Upload a file using redirected input:

```bash
$ http example.org < file.json
```

Download a file and save it via redirected output:

```bash
$ http example.org/file > file
```

You can supply any number of [HTTPie arguments](https://github.com/jakubroztocil/httpie#readme)
that will be passed through unmodified.

### Help

HTTPie has a fairly [extensive documentation](https://github.com/jakubroztocil/httpie#readme) available.
Also, you can use its included help output:

```bash
$ http --help
```

